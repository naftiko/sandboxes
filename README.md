# Manage Microcks
API mock services and OpenAPI spec imports via the Microcks API. Specs in [`specs/`](specs/) are baked into a container image and served by a Cloudflare Worker.

## Contributing a spec
See [CONTRIBUTING.md](CONTRIBUTING.md). Short version: open a PR adding a file under `specs/`. CI lints it; merge to `main` rolls the Cloudflare Worker forward automatically.

## CI / CD

Two GitHub Actions workflows under [`.github/workflows/`](.github/workflows/):

- [`lint-openapi.yml`](.github/workflows/lint-openapi.yml) — Super Linter validates `specs/*.yml`, `specs/*.yaml`, `specs/*.json` on every PR and push to `main`. OpenAPI structural validation + YAML/JSON shape checks. PR runs lint changed files only; push to `main` lints the full tree.
- [`deploy-microcks.yml`](.github/workflows/deploy-microcks.yml) — `wrangler deploy` runs on push to `main` and on manual dispatch. Builds the container image, pushes it, rolls the Cloudflare Worker forward.

Required GitHub repo secrets for the deploy workflow:

| Secret | Purpose |
|---|---|
| `CLOUDFLARE_API_TOKEN` | Token with `Workers Scripts:Edit` + `Account Containers:Edit` |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare account ID |

Worker basic-auth secrets (`MICROCKS_USER`, `MICROCKS_PASS`) live as Worker secrets via `npx wrangler secret put`, not in GitHub.

## Running locally

```bash
docker pull ghcr.io/naftiko/framework:latest

docker run -p 3010:3010 \
  -v ./capabilities/manage-microcks.naftiko.yml:/app/capability.yaml \
  --env-file .env \
  ghcr.io/naftiko/framework:latest /app/capability.yaml
```

## Environment Variables

See the `binds` block in `capabilities/manage-microcks.naftiko.yml` for required environment variables.

## MCP Tools

See the `exposes` block in `capabilities/manage-microcks.naftiko.yml` for the full list of available MCP tools.
