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

## Naming convention for `info.title` and `info.version`

The `info.title` and `info.version` of your spec are the namespace Microcks uses to route the mock. The mock endpoint is:

```
https://mocks.naftiko.net/rest/<info.title>/<info.version>/<path>
```

Both fields end up in the URL, so neither can contain anything that breaks a URL path segment.

**Title** — strict slug: lowercase, hyphen-separated, alphanumeric only (`^[a-z0-9]+(?:-[a-z0-9]+)*$`). No spaces, parentheses, em-dashes, periods, slashes, or capitalisation.

| Bad title | Good title |
|---|---|
| `Apache Spark REST API` | `apache-spark-rest-api` |
| `NIST SP 800-53 (Rev. 5) — Sandbox API` | `nist-sp-800-53-rev-5-sandbox-api` |
| `ACME Billing v2` | `acme-billing-v2` |

**Version** — URL-safe: alphanumeric, dot, hyphen only (`^[A-Za-z0-9.-]+$`). Semver like `1.0.0` and date-stamped versions like `2026-03-05` are fine as-is. Slashes, spaces, parens — anything else — must be scrubbed.

| Bad version | Good version |
|---|---|
| `v1/2.1-SNAPSHOT` | `v1-2.1-SNAPSHOT` |
| `2.0 (beta)` | `2.0-beta` |
| `1.0.0` | `1.0.0` ✓ |
| `2026-03-05` | `2026-03-05` ✓ |

The [`apply-slug-to-info-title.py`](apply-slug-to-info-title.py) helper at the repo root will normalise existing titles and versions in place if you need to backfill — it dry-runs by default; pass `--write` to apply.

## Submitting a change

1. Fork the repo
2. Create a branch (`git checkout -b add-acme-billing-spec`)
3. Drop your spec into `specs/`
4. Open a PR against `main`

The PR will run two checks automatically:

- **Lint OpenAPI specs** — Super Linter validates your spec is well-formed OpenAPI plus generic YAML/JSON shape. Only the files you changed are linted on a PR (fast feedback).
- **Deploy** — there is **no automatic deploy**. `mocks.naftiko.net` now runs on **GCP Cloud Run** and is redeployed **manually** by a maintainer (see below). Your merged spec goes live on the next manual redeploy.

If lint fails, fix the spec and push another commit. The check re-runs on each push.

## What the lint checks

- OpenAPI structure (paths, operations, parameters, schemas validate against the OpenAPI 3.x meta-schema)
- YAML syntax (no tabs, valid indentation, no duplicate keys)
- JSON syntax (well-formed, no trailing commas)

It does **not** check whether your spec semantically matches the upstream API. That's on the contributor — the spec is yours to author and maintain.

## What happens on merge

> **Note (2026-06).** `mocks.naftiko.net` was migrated off Cloudflare Workers +
> Containers to **GCP Cloud Run**. The old `Deploy Microcks to Cloudflare` workflow
> is **disabled** (`.github/workflows/deploy-microcks.yml`, `on: {}`), so a merge to
> `main` **no longer deploys anything automatically**. See the migration blueprint:
> `naftiko/blueprints/sandboxes-migration-plan.md`.

A merge to `main` only stores your spec in the repo. To publish it, a maintainer
**manually redeploys** the Cloud Run service (which rebuilds the container image,
baking every spec under `specs/` into it):

```bash
IMAGE=europe-west1-docker.pkg.dev/<project>/naftiko-mocks/microcks-sandboxes
gcloud builds submit --tag $IMAGE .
gcloud run deploy mocks --image $IMAGE --region europe-west1 \
  --set-secrets="ADMIN_PASSWORD_HASH=microcks-admin-hash:latest"
```

The new image is live on the public Microcks endpoint within ~1–2 minutes. A Caddy
reverse-proxy in front of Microcks serves the public mock paths openly and
basic-auth-protects the admin API/console. A GCP-based CI workflow will eventually
replace the manual step (migration plan, Phase 3).

## Required secrets (maintainer-side)

External contributors don't need anything. Deployment is currently manual (via a
maintainer's `gcloud` session), so **no GitHub Actions secrets are required** while
the Cloudflare workflow stays disabled.

Runtime secret (GCP Secret Manager, not GitHub):

| Secret | What it is |
|---|---|
| `microcks-admin-hash` | bcrypt hash of the Caddy basic-auth admin password (user `Naftiko`), injected as `ADMIN_PASSWORD_HASH`. The cleartext password lives in the team password store. |

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
