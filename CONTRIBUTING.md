# Contributing to manage-microcks

Thanks for adding or updating an API spec. This repo backs the public Naftiko Microcks instance — every spec under `specs/` becomes a mocked API after merge.

## What goes in `specs/`

OpenAPI 3.x documents only. One file per API. Filename pattern:

```
specs/<provider>-<api-name>-openapi.yml
specs/<provider>-<api-name>-openapi.yaml
specs/<provider>-<api-name>-openapi.json
```

YAML is preferred (most existing specs use `.yml`). JSON works if your source-of-truth is JSON.

## Submitting a change

1. Fork the repo
2. Create a branch (`git checkout -b add-acme-billing-spec`)
3. Drop your spec into `specs/`
4. Open a PR against `main`

The PR will run two checks automatically:

- **Lint OpenAPI specs** — Super Linter validates your spec is well-formed OpenAPI plus generic YAML/JSON shape. Only the files you changed are linted on a PR (fast feedback).
- **Deploy** — runs only after merge to `main`; rebuilds the container image with your spec and rolls the Cloudflare Worker forward.

If lint fails, fix the spec and push another commit. The check re-runs on each push.

## What the lint checks

- OpenAPI structure (paths, operations, parameters, schemas validate against the OpenAPI 3.x meta-schema)
- YAML syntax (no tabs, valid indentation, no duplicate keys)
- JSON syntax (well-formed, no trailing commas)

It does **not** check whether your spec semantically matches the upstream API. That's on the contributor — the spec is yours to author and maintain.

## What happens on merge

The `Deploy Microcks to Cloudflare` workflow runs on push to `main`:

1. Installs npm deps
2. Sets up Docker Buildx (needed for the container image)
3. Runs `wrangler deploy` — bakes every spec under `specs/` into a fresh container image, pushes it, and rolls the Cloudflare Worker forward
4. The new image is live on the public Microcks endpoint within ~1-2 minutes

The Worker proxies basic-auth-protected requests to the Microcks container. Your spec is reachable through that endpoint as soon as deploy finishes.

## Required secrets (maintainer-side)

External contributors don't need anything. Maintainers must set these in the GitHub repo settings → Secrets and variables → Actions:

| Secret | What it is |
|---|---|
| `CLOUDFLARE_API_TOKEN` | API token with `Workers Scripts:Edit` + `Account Containers:Edit` scopes. Create at https://dash.cloudflare.com/profile/api-tokens |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare account ID where the Worker lives |

Worker basic-auth credentials (`MICROCKS_USER`, `MICROCKS_PASS`) are stored as Worker secrets via `npx wrangler secret put` and persist across deploys — the GH Action doesn't touch them.

## Customizing the lint rules

If a spec is well-formed but Super Linter's strict ruleset rejects it (e.g. missing `operationId`, missing `tags` on operations), drop a `.spectral.yml` at the repo root to relax the rules. Example:

```yaml
extends: spectral:oas
rules:
  operation-operationId: warn
  operation-tags: off
```

Super Linter will pick up `.spectral.yml` automatically.

## Local validation before pushing

Optional, but faster than waiting on CI. With Spectral installed (`npm install -g @stoplight/spectral-cli`):

```bash
spectral lint specs/your-new-spec-openapi.yml
```

For a full local container build + run (validates the Dockerfile path):

```bash
docker buildx build --load -t microcks-local .
docker run --rm -p 8080:8080 microcks-local
# In another terminal:
sh import-specs.sh
```

## Questions

Open an issue. Tag the maintainer in the PR if you need eyes on a specific spec decision.
