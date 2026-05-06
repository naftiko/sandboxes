# Manage Microcks
A centralized mock service for tier 1 APIs, providing usable responses for many of these common APIs, using Microcks and OpenAPI to serve up via a Cloudflare Worker.

## Contributing a spec
See [CONTRIBUTING.md](CONTRIBUTING.md). Short version: open a PR adding a file under `specs/`. CI lints it; merge to `main` rolls the Cloudflare Worker forward automatically.

The `info.title` and `info.version` of your spec become part of the mock URL (`https://mocks.naftiko.net/rest/<info.title>/<info.version>/`). Title must be a strict slug (lowercase, hyphens, alphanumeric — e.g. `acme-billing-api`); version may include dots (e.g. `1.0.0`, `2026-03-05`) but must not contain slashes, spaces, or other URL-breaking characters. See [Naming convention](CONTRIBUTING.md#naming-convention-for-infotitle-and-infoversion).

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

<!-- MOCK_ENDPOINTS:START -->
## Mock Endpoints

All OpenAPIs in [`specs/`](specs/) are baked into the container and served by Microcks. Mock host: `https://mocks.naftiko.net`. Microcks exposes each spec at `/rest/<info.title>/<info.version><path>`.

**136 APIs** · **1690 paths** · **2213 operations**

`GET` operations are linked to the live mock; other methods (`POST`, `PUT`, `PATCH`, `DELETE`) are listed without a link since they need a request body to call.

<details><summary><strong>anthropic-admin-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0"><code>anthropic-admin-api/1.0.0</code></a> · 12 paths · <code>anthropic-admin-api-openapi.yml</code></summary>

- `/organizations/me` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/me)
- `/organizations/users` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/users)
- `/organizations/users/{user_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/users/{user_id}) `POST` `DELETE`
- `/organizations/invites` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/invites) `POST`
- `/organizations/invites/{invite_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/invites/{invite_id}) `DELETE`
- `/organizations/workspaces` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/workspaces) `POST`
- `/organizations/workspaces/{workspace_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/workspaces/{workspace_id}) `POST`
- `/organizations/workspaces/{workspace_id}/archive` — `POST`
- `/organizations/workspaces/{workspace_id}/members` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/workspaces/{workspace_id}/members) `POST`
- `/organizations/workspaces/{workspace_id}/members/{user_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/workspaces/{workspace_id}/members/{user_id}) `POST` `DELETE`
- `/organizations/api_keys` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/api_keys)
- `/organizations/api_keys/{api_key_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-admin-api/1.0.0/organizations/api_keys/{api_key_id}) `POST`

</details>

<details><summary><strong>anthropic-files-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/anthropic-files-api/1.0.0"><code>anthropic-files-api/1.0.0</code></a> · 3 paths · <code>anthropic-files-api-openapi.yml</code></summary>

- `/files` — [`GET`](https://mocks.naftiko.net/rest/anthropic-files-api/1.0.0/files) `POST`
- `/files/{file_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-files-api/1.0.0/files/{file_id}) `DELETE`
- `/files/{file_id}/content` — [`GET`](https://mocks.naftiko.net/rest/anthropic-files-api/1.0.0/files/{file_id}/content)

</details>

<details><summary><strong>anthropic-message-batches-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/anthropic-message-batches-api/1.0.0"><code>anthropic-message-batches-api/1.0.0</code></a> · 4 paths · <code>anthropic-message-batches-api-openapi.yml</code></summary>

- `/messages/batches` — [`GET`](https://mocks.naftiko.net/rest/anthropic-message-batches-api/1.0.0/messages/batches) `POST`
- `/messages/batches/{message_batch_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-message-batches-api/1.0.0/messages/batches/{message_batch_id}) `DELETE`
- `/messages/batches/{message_batch_id}/results` — [`GET`](https://mocks.naftiko.net/rest/anthropic-message-batches-api/1.0.0/messages/batches/{message_batch_id}/results)
- `/messages/batches/{message_batch_id}/cancel` — `POST`

</details>

<details><summary><strong>anthropic-prompt-tools-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/anthropic-prompt-tools-api/1.0.0"><code>anthropic-prompt-tools-api/1.0.0</code></a> · 3 paths · <code>anthropic-messages-api-openapi.yml</code></summary>

- `/v1/experimental/generate_prompt` — `POST`
- `/v1/experimental/improve_prompt` — `POST`
- `/v1/experimental/templatize_prompt` — `POST`

</details>

<details><summary><strong>anthropic-models-api</strong> · v2025-03-05 · <a href="https://mocks.naftiko.net/rest/anthropic-models-api/2025-03-05"><code>anthropic-models-api/2025-03-05</code></a> · 4 paths · <code>anthropic-models-api-openapi.yml</code></summary>

- `/v1/models` — [`GET`](https://mocks.naftiko.net/rest/anthropic-models-api/2025-03-05/v1/models)
- `/v1/models/{model_id}` — [`GET`](https://mocks.naftiko.net/rest/anthropic-models-api/2025-03-05/v1/models/{model_id})
- `/v1/messages` — `POST`
- `/v1/messages/count_tokens` — `POST`

</details>

<details><summary><strong>anthropic-prompt-tools-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/anthropic-prompt-tools-api/1.0.0"><code>anthropic-prompt-tools-api/1.0.0</code></a> · 3 paths · <code>anthropic-prompts-api-openapi.yml</code></summary>

- `/v1/experimental/generate_prompt` — `POST`
- `/v1/experimental/improve_prompt` — `POST`
- `/v1/experimental/templatize_prompt` — `POST`

</details>

<details><summary><strong>flink-jobmanager-rest-api</strong> · vv1-2.1-SNAPSHOT · <a href="https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT"><code>flink-jobmanager-rest-api/v1-2.1-SNAPSHOT</code></a> · 66 paths · <code>apache-flink-openapi.yaml</code></summary>

- `/cluster` — `DELETE`
- `/config` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/config)
- `/datasets` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/datasets)
- `/datasets/delete/{triggerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/datasets/delete/{triggerid})
- `/datasets/{datasetid}` — `DELETE`
- `/jars` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jars)
- `/jars/upload` — `POST`
- `/jars/{jarid}` — `DELETE`
- `/jars/{jarid}/plan` — `POST`
- `/jars/{jarid}/run` — `POST`
- `/jobmanager/config` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobmanager/config)
- `/jobmanager/environment` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobmanager/environment)
- `/jobmanager/logs` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobmanager/logs)
- `/jobmanager/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobmanager/metrics)
- `/jobmanager/thread-dump` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobmanager/thread-dump)
- `/jobs` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs)
- `/jobs/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/metrics)
- `/jobs/overview` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/overview)
- `/jobs/{jobid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}) `PATCH`
- `/jobs/{jobid}/accumulators` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/accumulators)
- `/jobs/{jobid}/checkpoints` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/checkpoints) `POST`
- `/jobs/{jobid}/checkpoints/config` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/checkpoints/config)
- `/jobs/{jobid}/checkpoints/details/{checkpointid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/checkpoints/details/{checkpointid})
- `/jobs/{jobid}/checkpoints/details/{checkpointid}/subtasks/{vertexid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/checkpoints/details/{checkpointid}/subtasks/{vertexid})
- `/jobs/{jobid}/checkpoints/{triggerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/checkpoints/{triggerid})
- `/jobs/{jobid}/clientHeartbeat` — `PATCH`
- `/jobs/{jobid}/config` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/config)
- `/jobs/{jobid}/exceptions` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/exceptions)
- `/jobs/{jobid}/execution-result` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/execution-result)
- `/jobs/{jobid}/jobmanager/config` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/jobmanager/config)
- `/jobs/{jobid}/jobmanager/environment` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/jobmanager/environment)
- `/jobs/{jobid}/jobmanager/log-url` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/jobmanager/log-url)
- `/jobs/{jobid}/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/metrics)
- `/jobs/{jobid}/plan` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/plan)
- `/jobs/{jobid}/rescaling` — `PATCH`
- `/jobs/{jobid}/rescaling/{triggerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/rescaling/{triggerid})
- `/jobs/{jobid}/resource-requirements` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/resource-requirements) `PUT`
- `/jobs/{jobid}/savepoints` — `POST`
- `/jobs/{jobid}/savepoints/{triggerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/savepoints/{triggerid})
- `/jobs/{jobid}/status` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/status)
- `/jobs/{jobid}/stop` — `POST`
- `/jobs/{jobid}/taskmanagers/{taskmanagerid}/log-url` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/taskmanagers/{taskmanagerid}/log-url)
- `/jobs/{jobid}/vertices/{vertexid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid})
- `/jobs/{jobid}/vertices/{vertexid}/accumulators` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/accumulators)
- `/jobs/{jobid}/vertices/{vertexid}/backpressure` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/backpressure)
- `/jobs/{jobid}/vertices/{vertexid}/flamegraph` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/flamegraph)
- `/jobs/{jobid}/vertices/{vertexid}/jm-operator-metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/jm-operator-metrics)
- `/jobs/{jobid}/vertices/{vertexid}/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/metrics)
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/accumulators` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/accumulators)
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/metrics)
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex})
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/attempts/{attempt}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/attempts/{attempt})
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/attempts/{attempt}/accumulators` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/attempts/{attempt}/accumulators)
- `/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasks/{subtaskindex}/metrics)
- `/jobs/{jobid}/vertices/{vertexid}/subtasktimes` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/subtasktimes)
- `/jobs/{jobid}/vertices/{vertexid}/taskmanagers` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/taskmanagers)
- `/jobs/{jobid}/vertices/{vertexid}/watermarks` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/jobs/{jobid}/vertices/{vertexid}/watermarks)
- `/overview` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/overview)
- `/savepoint-disposal` — `POST`
- `/savepoint-disposal/{triggerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/savepoint-disposal/{triggerid})
- `/taskmanagers` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers)
- `/taskmanagers/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers/metrics)
- `/taskmanagers/{taskmanagerid}` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers/{taskmanagerid})
- `/taskmanagers/{taskmanagerid}/logs` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers/{taskmanagerid}/logs)
- `/taskmanagers/{taskmanagerid}/metrics` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers/{taskmanagerid}/metrics)
- `/taskmanagers/{taskmanagerid}/thread-dump` — [`GET`](https://mocks.naftiko.net/rest/flink-jobmanager-rest-api/v1-2.1-SNAPSHOT/taskmanagers/{taskmanagerid}/thread-dump)

</details>

<details><summary><strong>apache-spark-rest-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0"><code>apache-spark-rest-api/1.0.0</code></a> · 29 paths · <code>apache-spark-openapi.yaml</code></summary>

- `/applications` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications)
- `/applications/{appId}/jobs` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/jobs)
- `/applications/{appId}/jobs/{jobId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/jobs/{jobId})
- `/applications/{appId}/stages` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/stages)
- `/applications/{appId}/stages/{stageId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/stages/{stageId})
- `/applications/{appId}/stages/{stageId}/{stageAttemptId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/stages/{stageId}/{stageAttemptId})
- `/applications/{appId}/stages/{stageId}/{stageAttemptId}/taskSummary` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/stages/{stageId}/{stageAttemptId}/taskSummary)
- `/applications/{appId}/stages/{stageId}/{stageAttemptId}/taskList` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/stages/{stageId}/{stageAttemptId}/taskList)
- `/applications/{appId}/executors` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/executors)
- `/applications/{appId}/allexecutors` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/allexecutors)
- `/applications/{appId}/executors/{executorId}/threads` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/executors/{executorId}/threads)
- `/applications/{appId}/storage/rdd` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/storage/rdd)
- `/applications/{appId}/storage/rdd/{rddId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/storage/rdd/{rddId})
- `/applications/{appId}/logs` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/logs)
- `/applications/{appId}/{attemptId}/logs` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/{attemptId}/logs)
- `/applications/{appId}/streaming/statistics` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/statistics)
- `/applications/{appId}/streaming/receivers` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/receivers)
- `/applications/{appId}/streaming/receivers/{streamId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/receivers/{streamId})
- `/applications/{appId}/streaming/batches` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/batches)
- `/applications/{appId}/streaming/batches/{batchId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/batches/{batchId})
- `/applications/{appId}/streaming/batches/{batchId}/operations` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/batches/{batchId}/operations)
- `/applications/{appId}/streaming/batches/{batchId}/operations/{outputOpId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/streaming/batches/{batchId}/operations/{outputOpId})
- `/applications/{appId}/sql` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/sql)
- `/applications/{appId}/sql/{executionId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/sql/{executionId})
- `/applications/{appId}/environment` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/applications/{appId}/environment)
- `/version` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/version)
- `/v1/submissions/create` — `POST`
- `/v1/submissions/status/{submissionId}` — [`GET`](https://mocks.naftiko.net/rest/apache-spark-rest-api/1.0.0/v1/submissions/status/{submissionId})
- `/v1/submissions/kill/{submissionId}` — `POST`

</details>

<details><summary><strong>governance-rules-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/governance-rules-api/1.0.0"><code>governance-rules-api/1.0.0</code></a> · 21 paths · <code>api-governance-rules-openapi.yml</code></summary>

- `/rules/best-practices` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/best-practices)
- `/rules/caching` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/caching)
- `/rules/compatibility` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/compatibility)
- `/rules/documentation` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/documentation)
- `/rules/error-handling` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/error-handling)
- `/rules/examples` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/examples)
- `/rules/headers` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/headers)
- `/rules/http-methods` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/http-methods)
- `/rules/naming-conventions` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/naming-conventions)
- `/rules/operations` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/operations)
- `/rules/pagination` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/pagination)
- `/rules/parameters` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/parameters)
- `/rules/paths` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/paths)
- `/rules/rate-limiting` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/rate-limiting)
- `/rules/request-response` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/request-response)
- `/rules/responses` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/responses)
- `/rules/schemas` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/schemas)
- `/rules/security` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/security)
- `/rules/servers` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/servers)
- `/rules/validation` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules/validation)
- `/rules` — [`GET`](https://mocks.naftiko.net/rest/governance-rules-api/1.0.0/rules)

</details>

<details><summary><strong>api-governance-platform</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/api-governance-platform/1.0.0"><code>api-governance-platform/1.0.0</code></a> · 40 paths · <code>api-governance-rules-with-style-guide-apiops-cycles-openapi.yml</code></summary>

- `/projects` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects) `POST`
- `/projects/{projectId}` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects/{projectId}) `PATCH` `DELETE`
- `/projects/{projectId}/canvases` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects/{projectId}/canvases) `POST`
- `/projects/{projectId}/canvases/{canvasId}` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects/{projectId}/canvases/{canvasId}) `PATCH`
- `/projects/{projectId}/specifications` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects/{projectId}/specifications) `POST`
- `/projects/{projectId}/validate` — `POST`
- `/projects/{projectId}/compliance` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/projects/{projectId}/compliance)
- `/canvases` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases)
- `/canvases/business/customer-journey` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/business/customer-journey)
- `/canvases/business/api-business-model` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/business/api-business-model)
- `/canvases/business/api-value-proposition` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/business/api-value-proposition)
- `/canvases/business/business-impact` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/business/business-impact)
- `/canvases/technical/rest` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/technical/rest)
- `/canvases/technical/graphql` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/technical/graphql)
- `/canvases/technical/event` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/technical/event)
- `/canvases/technical/interaction` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/technical/interaction)
- `/canvases/technical/domain` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/technical/domain)
- `/canvases/operational/capacity` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/operational/capacity)
- `/canvases/operational/locations` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/canvases/operational/locations)
- `/guidelines` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines)
- `/guidelines/search` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/search)
- `/guidelines/design-principles` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/design-principles)
- `/guidelines/url-structure` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/url-structure)
- `/guidelines/naming-conventions` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/naming-conventions)
- `/guidelines/http-methods` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/http-methods)
- `/guidelines/http-status-codes` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/http-status-codes)
- `/guidelines/data-types` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/data-types)
- `/guidelines/error-handling` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/error-handling)
- `/guidelines/collections` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/collections)
- `/guidelines/security` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/security)
- `/guidelines/versioning` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/guidelines/versioning)
- `/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/rules)
- `/rules/{ruleId}` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/rules/{ruleId})
- `/rules/profiles` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/rules/profiles)
- `/rules/profiles/{profileId}` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/rules/profiles/{profileId})
- `/rules/spectral-export` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/rules/spectral-export)
- `/standards` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/standards)
- `/standards/{categoryId}` — [`GET`](https://mocks.naftiko.net/rest/api-governance-platform/1.0.0/standards/{categoryId})
- `/validate` — `POST`
- `/validate/breaking-changes` — `POST`

</details>

<details><summary><strong>api-governance-rules-with-style-guide</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0"><code>api-governance-rules-with-style-guide/1.0.0</code></a> · 60 paths · <code>api-governance-rules-with-style-guide-openapi.yml</code></summary>

- `/guidelines/introduction` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/introduction)
- `/guidelines/introduction/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/introduction/rules)
- `/guidelines/introduction/purpose` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/introduction/purpose)
- `/guidelines/introduction/requirements-language` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/introduction/requirements-language)
- `/guidelines/design-principles` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/design-principles)
- `/guidelines/design-principles/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/design-principles/rules)
- `/guidelines/design-principles/api-first` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/design-principles/api-first)
- `/guidelines/design-principles/robustness` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/design-principles/robustness)
- `/guidelines/url-structure` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/url-structure)
- `/guidelines/url-structure/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/url-structure/rules)
- `/guidelines/url-structure/general-format` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/url-structure/general-format)
- `/guidelines/url-structure/resource-naming` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/url-structure/resource-naming)
- `/guidelines/url-structure/path-segments` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/url-structure/path-segments)
- `/guidelines/naming-conventions` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/naming-conventions)
- `/guidelines/naming-conventions/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/naming-conventions/rules)
- `/guidelines/naming-conventions/json-properties` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/naming-conventions/json-properties)
- `/guidelines/naming-conventions/http-headers` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/naming-conventions/http-headers)
- `/guidelines/http-methods` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods)
- `/guidelines/http-methods/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods/rules)
- `/guidelines/http-methods/semantics` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods/semantics)
- `/guidelines/http-methods/get` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods/get)
- `/guidelines/http-methods/post` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods/post)
- `/guidelines/http-methods/delete` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-methods/delete)
- `/guidelines/http-status-codes` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-status-codes)
- `/guidelines/http-status-codes/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-status-codes/rules)
- `/guidelines/http-status-codes/recommended` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-status-codes/recommended)
- `/guidelines/http-status-codes/by-method` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/http-status-codes/by-method)
- `/guidelines/data-types` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/data-types)
- `/guidelines/data-types/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/data-types/rules)
- `/guidelines/data-types/standard-types` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/data-types/standard-types)
- `/guidelines/data-types/date-time` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/data-types/date-time)
- `/guidelines/data-types/money` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/data-types/money)
- `/guidelines/error-handling` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/error-handling)
- `/guidelines/error-handling/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/error-handling/rules)
- `/guidelines/error-handling/response-format` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/error-handling/response-format)
- `/guidelines/collections` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/collections)
- `/guidelines/collections/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/collections/rules)
- `/guidelines/collections/pagination` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/collections/pagination)
- `/guidelines/security` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/security)
- `/guidelines/security/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/security/rules)
- `/guidelines/security/transport` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/security/transport)
- `/guidelines/security/authentication` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/security/authentication)
- `/guidelines/versioning` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/versioning)
- `/guidelines/versioning/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/versioning/rules)
- `/guidelines/versioning/strategies` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/versioning/strategies)
- `/guidelines/versioning/breaking-changes` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/versioning/breaking-changes)
- `/guidelines` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines)
- `/guidelines/search` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/search)
- `/guidelines/rules` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/guidelines/rules)
- `/standards` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards)
- `/standards/rfc` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/rfc)
- `/standards/iso` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/iso)
- `/standards/openapi-json-schema` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/openapi-json-schema)
- `/standards/hypermedia` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/hypermedia)
- `/standards/security-standards` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/security-standards)
- `/standards/versioning-standards` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/versioning-standards)
- `/standards/naming-conventions` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/naming-conventions)
- `/standards/http-status-codes` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/http-status-codes)
- `/standards/content-types` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/content-types)
- `/standards/pagination-rate-limiting` — [`GET`](https://mocks.naftiko.net/rest/api-governance-rules-with-style-guide/1.0.0/standards/pagination-rate-limiting)

</details>

<details><summary><strong>webflow-asset-folders-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-asset-folders-api/1.0.0"><code>webflow-asset-folders-api/1.0.0</code></a> · 2 paths · <code>asset-folders-openapi-original.yml</code></summary>

- `/sites/{site_id}/asset_folders` — [`GET`](https://mocks.naftiko.net/rest/webflow-asset-folders-api/1.0.0/sites/{site_id}/asset_folders) `POST`
- `/asset_folders/{asset_folder_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-asset-folders-api/1.0.0/asset_folders/{asset_folder_id})

</details>

<details><summary><strong>webflow-assets-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-assets-api/1.0.0"><code>webflow-assets-api/1.0.0</code></a> · 2 paths · <code>assets-openapi-original.yml</code></summary>

- `/sites/{site_id}/assets` — [`GET`](https://mocks.naftiko.net/rest/webflow-assets-api/1.0.0/sites/{site_id}/assets) `POST`
- `/assets/{asset_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-assets-api/1.0.0/assets/{asset_id}) `PATCH` `DELETE`

</details>

<details><summary><strong>openai-assistants-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/openai-assistants-api/2.0.0"><code>openai-assistants-api/2.0.0</code></a> · 4 paths · <code>assistants-openapi-original.yml</code></summary>

- `/assistants` — [`GET`](https://mocks.naftiko.net/rest/openai-assistants-api/2.0.0/assistants) `POST`
- `/assistants/{assistant_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-assistants-api/2.0.0/assistants/{assistant_id}) `POST` `DELETE`
- `/assistants/{assistant_id}/files` — [`GET`](https://mocks.naftiko.net/rest/openai-assistants-api/2.0.0/assistants/{assistant_id}/files) `POST`
- `/assistants/{assistant_id}/files/{file_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-assistants-api/2.0.0/assistants/{assistant_id}/files/{file_id}) `DELETE`

</details>

<details><summary><strong>openai-audio-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/openai-audio-api/2.0.0"><code>openai-audio-api/2.0.0</code></a> · 3 paths · <code>audio-openapi-original.yml</code></summary>

- `/audio/speech` — `POST`
- `/audio/transcriptions` — `POST`
- `/audio/translations` — `POST`

</details>

<details><summary><strong>bluesky-social-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0"><code>bluesky-social-api/1.0.0</code></a> · 168 paths · <code>bluesky-openapi.yml</code></summary>

- `/xrpc/app.bsky.actor.getPreferences` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.getPreferences)
- `/xrpc/app.bsky.actor.getProfile` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.getProfile)
- `/xrpc/app.bsky.actor.getProfiles` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.getProfiles)
- `/xrpc/app.bsky.actor.getSuggestions` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.getSuggestions)
- `/xrpc/app.bsky.actor.putPreferences` — `POST`
- `/xrpc/app.bsky.actor.searchActors` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.searchActors)
- `/xrpc/app.bsky.actor.searchActorsTypeahead` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.actor.searchActorsTypeahead)
- `/xrpc/app.bsky.feed.describeFeedGenerator` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.describeFeedGenerator)
- `/xrpc/app.bsky.feed.getActorFeeds` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getActorFeeds)
- `/xrpc/app.bsky.feed.getActorLikes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getActorLikes)
- `/xrpc/app.bsky.feed.getAuthorFeed` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getAuthorFeed)
- `/xrpc/app.bsky.feed.getFeed` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getFeed)
- `/xrpc/app.bsky.feed.getFeedGenerator` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getFeedGenerator)
- `/xrpc/app.bsky.feed.getFeedGenerators` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getFeedGenerators)
- `/xrpc/app.bsky.feed.getFeedSkeleton` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getFeedSkeleton)
- `/xrpc/app.bsky.feed.getLikes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getLikes)
- `/xrpc/app.bsky.feed.getListFeed` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getListFeed)
- `/xrpc/app.bsky.feed.getPostThread` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getPostThread)
- `/xrpc/app.bsky.feed.getPosts` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getPosts)
- `/xrpc/app.bsky.feed.getQuotes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getQuotes)
- `/xrpc/app.bsky.feed.getRepostedBy` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getRepostedBy)
- `/xrpc/app.bsky.feed.getSuggestedFeeds` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getSuggestedFeeds)
- `/xrpc/app.bsky.feed.getTimeline` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.getTimeline)
- `/xrpc/app.bsky.feed.searchPosts` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.feed.searchPosts)
- `/xrpc/app.bsky.feed.sendInteractions` — `POST`
- `/xrpc/app.bsky.graph.getActorStarterPacks` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getActorStarterPacks)
- `/xrpc/app.bsky.graph.getBlocks` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getBlocks)
- `/xrpc/app.bsky.graph.getFollowers` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getFollowers)
- `/xrpc/app.bsky.graph.getFollows` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getFollows)
- `/xrpc/app.bsky.graph.getKnownFollowers` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getKnownFollowers)
- `/xrpc/app.bsky.graph.getList` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getList)
- `/xrpc/app.bsky.graph.getListBlocks` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getListBlocks)
- `/xrpc/app.bsky.graph.getListMutes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getListMutes)
- `/xrpc/app.bsky.graph.getLists` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getLists)
- `/xrpc/app.bsky.graph.getMutes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getMutes)
- `/xrpc/app.bsky.graph.getRelationships` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getRelationships)
- `/xrpc/app.bsky.graph.getStarterPack` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getStarterPack)
- `/xrpc/app.bsky.graph.getStarterPacks` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getStarterPacks)
- `/xrpc/app.bsky.graph.getSuggestedFollowsByActor` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.graph.getSuggestedFollowsByActor)
- `/xrpc/app.bsky.graph.muteActor` — `POST`
- `/xrpc/app.bsky.graph.muteActorList` — `POST`
- `/xrpc/app.bsky.graph.muteThread` — `POST`
- `/xrpc/app.bsky.graph.unmuteActor` — `POST`
- `/xrpc/app.bsky.graph.unmuteActorList` — `POST`
- `/xrpc/app.bsky.graph.unmuteThread` — `POST`
- `/xrpc/app.bsky.labeler.getServices` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.labeler.getServices)
- `/xrpc/app.bsky.notification.getUnreadCount` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.notification.getUnreadCount)
- `/xrpc/app.bsky.notification.listNotifications` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.notification.listNotifications)
- `/xrpc/app.bsky.notification.putPreferences` — `POST`
- `/xrpc/app.bsky.notification.registerPush` — `POST`
- `/xrpc/app.bsky.notification.updateSeen` — `POST`
- `/xrpc/app.bsky.video.getJobStatus` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.video.getJobStatus)
- `/xrpc/app.bsky.video.getUploadLimits` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/app.bsky.video.getUploadLimits)
- `/xrpc/app.bsky.video.uploadVideo` — `POST`
- `/xrpc/chat.bsky.actor.deleteAccount` — `POST`
- `/xrpc/chat.bsky.actor.exportAccountData` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.actor.exportAccountData)
- `/xrpc/chat.bsky.convo.deleteMessageForSelf` — `POST`
- `/xrpc/chat.bsky.convo.getConvo` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.convo.getConvo)
- `/xrpc/chat.bsky.convo.getConvoForMembers` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.convo.getConvoForMembers)
- `/xrpc/chat.bsky.convo.getLog` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.convo.getLog)
- `/xrpc/chat.bsky.convo.getMessages` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.convo.getMessages)
- `/xrpc/chat.bsky.convo.leaveConvo` — `POST`
- `/xrpc/chat.bsky.convo.listConvos` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.convo.listConvos)
- `/xrpc/chat.bsky.convo.muteConvo` — `POST`
- `/xrpc/chat.bsky.convo.sendMessage` — `POST`
- `/xrpc/chat.bsky.convo.sendMessageBatch` — `POST`
- `/xrpc/chat.bsky.convo.unmuteConvo` — `POST`
- `/xrpc/chat.bsky.convo.updateRead` — `POST`
- `/xrpc/chat.bsky.moderation.getActorMetadata` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.moderation.getActorMetadata)
- `/xrpc/chat.bsky.moderation.getMessageContext` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/chat.bsky.moderation.getMessageContext)
- `/xrpc/chat.bsky.moderation.updateActorAccess` — `POST`
- `/xrpc/com.atproto.admin.deleteAccount` — `POST`
- `/xrpc/com.atproto.admin.disableAccountInvites` — `POST`
- `/xrpc/com.atproto.admin.disableInviteCodes` — `POST`
- `/xrpc/com.atproto.admin.enableAccountInvites` — `POST`
- `/xrpc/com.atproto.admin.getAccountInfo` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.admin.getAccountInfo)
- `/xrpc/com.atproto.admin.getAccountInfos` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.admin.getAccountInfos)
- `/xrpc/com.atproto.admin.getInviteCodes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.admin.getInviteCodes)
- `/xrpc/com.atproto.admin.getSubjectStatus` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.admin.getSubjectStatus)
- `/xrpc/com.atproto.admin.searchAccounts` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.admin.searchAccounts)
- `/xrpc/com.atproto.admin.sendEmail` — `POST`
- `/xrpc/com.atproto.admin.updateAccountEmail` — `POST`
- `/xrpc/com.atproto.admin.updateAccountHandle` — `POST`
- `/xrpc/com.atproto.admin.updateAccountPassword` — `POST`
- `/xrpc/com.atproto.admin.updateSubjectStatus` — `POST`
- `/xrpc/com.atproto.identity.getRecommendedDidCredentials` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.identity.getRecommendedDidCredentials)
- `/xrpc/com.atproto.identity.requestPlcOperationSignature` — `POST`
- `/xrpc/com.atproto.identity.resolveHandle` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.identity.resolveHandle)
- `/xrpc/com.atproto.identity.signPlcOperation` — `POST`
- `/xrpc/com.atproto.identity.submitPlcOperation` — `POST`
- `/xrpc/com.atproto.identity.updateHandle` — `POST`
- `/xrpc/com.atproto.label.queryLabels` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.label.queryLabels)
- `/xrpc/com.atproto.moderation.createReport` — `POST`
- `/xrpc/com.atproto.repo.applyWrites` — `POST`
- `/xrpc/com.atproto.repo.createRecord` — `POST`
- `/xrpc/com.atproto.repo.deleteRecord` — `POST`
- `/xrpc/com.atproto.repo.describeRepo` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.repo.describeRepo)
- `/xrpc/com.atproto.repo.getRecord` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.repo.getRecord)
- `/xrpc/com.atproto.repo.importRepo` — `POST`
- `/xrpc/com.atproto.repo.listMissingBlobs` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.repo.listMissingBlobs)
- `/xrpc/com.atproto.repo.listRecords` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.repo.listRecords)
- `/xrpc/com.atproto.repo.putRecord` — `POST`
- `/xrpc/com.atproto.repo.uploadBlob` — `POST`
- `/xrpc/com.atproto.server.activateAccount` — `POST`
- `/xrpc/com.atproto.server.checkAccountStatus` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.checkAccountStatus)
- `/xrpc/com.atproto.server.confirmEmail` — `POST`
- `/xrpc/com.atproto.server.createAccount` — `POST`
- `/xrpc/com.atproto.server.createAppPassword` — `POST`
- `/xrpc/com.atproto.server.createInviteCode` — `POST`
- `/xrpc/com.atproto.server.createInviteCodes` — `POST`
- `/xrpc/com.atproto.server.createSession` — `POST`
- `/xrpc/com.atproto.server.deactivateAccount` — `POST`
- `/xrpc/com.atproto.server.deleteAccount` — `POST`
- `/xrpc/com.atproto.server.deleteSession` — `POST`
- `/xrpc/com.atproto.server.describeServer` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.describeServer)
- `/xrpc/com.atproto.server.getAccountInviteCodes` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.getAccountInviteCodes)
- `/xrpc/com.atproto.server.getServiceAuth` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.getServiceAuth)
- `/xrpc/com.atproto.server.getSession` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.getSession)
- `/xrpc/com.atproto.server.listAppPasswords` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.server.listAppPasswords)
- `/xrpc/com.atproto.server.refreshSession` — `POST`
- `/xrpc/com.atproto.server.requestAccountDelete` — `POST`
- `/xrpc/com.atproto.server.requestEmailConfirmation` — `POST`
- `/xrpc/com.atproto.server.requestEmailUpdate` — `POST`
- `/xrpc/com.atproto.server.requestPasswordReset` — `POST`
- `/xrpc/com.atproto.server.reserveSigningKey` — `POST`
- `/xrpc/com.atproto.server.resetPassword` — `POST`
- `/xrpc/com.atproto.server.revokeAppPassword` — `POST`
- `/xrpc/com.atproto.server.updateEmail` — `POST`
- `/xrpc/com.atproto.sync.getBlob` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getBlob)
- `/xrpc/com.atproto.sync.getBlocks` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getBlocks)
- `/xrpc/com.atproto.sync.getLatestCommit` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getLatestCommit)
- `/xrpc/com.atproto.sync.getRecord` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getRecord)
- `/xrpc/com.atproto.sync.getRepo` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getRepo)
- `/xrpc/com.atproto.sync.getRepoStatus` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.getRepoStatus)
- `/xrpc/com.atproto.sync.listBlobs` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.listBlobs)
- `/xrpc/com.atproto.sync.listRepos` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/com.atproto.sync.listRepos)
- `/xrpc/com.atproto.sync.notifyOfUpdate` — `POST`
- `/xrpc/com.atproto.sync.requestCrawl` — `POST`
- `/xrpc/tools.ozone.communication.createTemplate` — `POST`
- `/xrpc/tools.ozone.communication.deleteTemplate` — `POST`
- `/xrpc/tools.ozone.communication.listTemplates` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.communication.listTemplates)
- `/xrpc/tools.ozone.communication.updateTemplate` — `POST`
- `/xrpc/tools.ozone.moderation.emitEvent` — `POST`
- `/xrpc/tools.ozone.moderation.getEvent` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.getEvent)
- `/xrpc/tools.ozone.moderation.getRecord` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.getRecord)
- `/xrpc/tools.ozone.moderation.getRecords` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.getRecords)
- `/xrpc/tools.ozone.moderation.getRepo` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.getRepo)
- `/xrpc/tools.ozone.moderation.getRepos` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.getRepos)
- `/xrpc/tools.ozone.moderation.queryEvents` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.queryEvents)
- `/xrpc/tools.ozone.moderation.queryStatuses` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.queryStatuses)
- `/xrpc/tools.ozone.moderation.searchRepos` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.moderation.searchRepos)
- `/xrpc/tools.ozone.server.getConfig` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.server.getConfig)
- `/xrpc/tools.ozone.set.addValues` — `POST`
- `/xrpc/tools.ozone.set.deleteSet` — `POST`
- `/xrpc/tools.ozone.set.deleteValues` — `POST`
- `/xrpc/tools.ozone.set.getValues` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.set.getValues)
- `/xrpc/tools.ozone.set.querySets` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.set.querySets)
- `/xrpc/tools.ozone.set.upsertSet` — `POST`
- `/xrpc/tools.ozone.setting.listOptions` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.setting.listOptions)
- `/xrpc/tools.ozone.setting.removeOptions` — `POST`
- `/xrpc/tools.ozone.setting.upsertOption` — `POST`
- `/xrpc/tools.ozone.signature.findCorrelation` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.signature.findCorrelation)
- `/xrpc/tools.ozone.signature.findRelatedAccounts` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.signature.findRelatedAccounts)
- `/xrpc/tools.ozone.signature.searchAccounts` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.signature.searchAccounts)
- `/xrpc/tools.ozone.team.addMember` — `POST`
- `/xrpc/tools.ozone.team.deleteMember` — `POST`
- `/xrpc/tools.ozone.team.listMembers` — [`GET`](https://mocks.naftiko.net/rest/bluesky-social-api/1.0.0/xrpc/tools.ozone.team.listMembers)
- `/xrpc/tools.ozone.team.updateMember` — `POST`

</details>

<details><summary><strong>openai-chat-completions-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/openai-chat-completions-api/2.0.0"><code>openai-chat-completions-api/2.0.0</code></a> · 1 paths · <code>chat-openapi-original.yml</code></summary>

- `/chat/completions` — `POST`

</details>

<details><summary><strong>webflow-collections-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0"><code>webflow-collections-api/1.0.0</code></a> · 11 paths · <code>collections-openapi-original.yml</code></summary>

- `/sites/{site_id}/collections` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/sites/{site_id}/collections) `POST`
- `/collections/{collection_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{collection_id}) `DELETE`
- `/collections/{collection_id}/fields` — `POST`
- `/collections/{collection_id}/fields/{field_id}` — `PATCH` `DELETE`
- `/collections/{collection_id}/items` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{collection_id}/items) `POST` `PATCH` `DELETE`
- `/collections/{collection_id}/items/live` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{collection_id}/items/live) `POST` `PATCH` `DELETE`
- `/collections/{collection_id}/items/bulk` — `POST`
- `/collections/{collection_id}/items/{item_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{collection_id}/items/{item_id}) `PATCH` `DELETE`
- `/collections/{collection_id}/items/{item_id}/live` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{collection_id}/items/{item_id}/live) `PATCH` `DELETE`
- `/collections/{collection_id}/items/publish` — `POST`
- `/collections/{sku_collection_id}/items/{sku_id}/inventory` — [`GET`](https://mocks.naftiko.net/rest/webflow-collections-api/1.0.0/collections/{sku_collection_id}/items/{sku_id}/inventory) `PATCH`

</details>

<details><summary><strong>openai-completions-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/openai-completions-api/2.0.0"><code>openai-completions-api/2.0.0</code></a> · 1 paths · <code>completions-openapi-original.yml</code></summary>

- `/completions` — `POST`

</details>

<details><summary><strong>openai-embeddings-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/openai-embeddings-api/2.0.0"><code>openai-embeddings-api/2.0.0</code></a> · 1 paths · <code>embeddings-openapi-original.yml</code></summary>

- `/embeddings` — `POST`

</details>

<details><summary><strong>figma-activity-logs-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-activity-logs-api/0.21.0"><code>figma-activity-logs-api/0.21.0</code></a> · 1 paths · <code>figma-activity-logs-api-openapi.yml</code></summary>

- `/v1/activity_logs` — [`GET`](https://mocks.naftiko.net/rest/figma-activity-logs-api/0.21.0/v1/activity_logs)

</details>

<details><summary><strong>figma-analytics-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-analytics-api/0.21.0"><code>figma-analytics-api/0.21.0</code></a> · 1 paths · <code>figma-analytics-api-openapi.yml</code></summary>

- `/v1/analytics/libraries/{file_key}/usages` — [`GET`](https://mocks.naftiko.net/rest/figma-analytics-api/0.21.0/v1/analytics/libraries/{file_key}/usages)

</details>

<details><summary><strong>figma-component-sets-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-component-sets-api/0.21.0"><code>figma-component-sets-api/0.21.0</code></a> · 1 paths · <code>figma-component-sets-api-openapi.yml</code></summary>

- `/v1/component_sets/{key}` — [`GET`](https://mocks.naftiko.net/rest/figma-component-sets-api/0.21.0/v1/component_sets/{key})

</details>

<details><summary><strong>figma-dev-resources-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-dev-resources-api/0.21.0"><code>figma-dev-resources-api/0.21.0</code></a> · 1 paths · <code>figma-dev-resources-api-openapi.yml</code></summary>

- `/v1/dev_resources` — `POST` `PUT`

</details>

<details><summary><strong>figma-files-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-files-api/0.21.0"><code>figma-files-api/0.21.0</code></a> · 1 paths · <code>figma-files-api-openapi.yml</code></summary>

- `/v1/files/{file_key}/dev_resources/{dev_resource_id}` — `DELETE`

</details>

<details><summary><strong>figma-images-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-images-api/0.21.0"><code>figma-images-api/0.21.0</code></a> · 1 paths · <code>figma-images-api-openapi.yml</code></summary>

- `/v1/images/{file_key}` — [`GET`](https://mocks.naftiko.net/rest/figma-images-api/0.21.0/v1/images/{file_key})

</details>

<details><summary><strong>figma-me-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-me-api/0.21.0"><code>figma-me-api/0.21.0</code></a> · 1 paths · <code>figma-me-api-openapi.yml</code></summary>

- `/v1/me` — [`GET`](https://mocks.naftiko.net/rest/figma-me-api/0.21.0/v1/me)

</details>

<details><summary><strong>figma-payments-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-payments-api/0.21.0"><code>figma-payments-api/0.21.0</code></a> · 1 paths · <code>figma-payments-api-openapi.yml</code></summary>

- `/v1/payments` — [`GET`](https://mocks.naftiko.net/rest/figma-payments-api/0.21.0/v1/payments)

</details>

<details><summary><strong>figma-projects-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-projects-api/0.21.0"><code>figma-projects-api/0.21.0</code></a> · 1 paths · <code>figma-projects-api-openapi.yml</code></summary>

- `/v1/projects/{project_id}/files` — [`GET`](https://mocks.naftiko.net/rest/figma-projects-api/0.21.0/v1/projects/{project_id}/files)

</details>

<details><summary><strong>figma-styles-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-styles-api/0.21.0"><code>figma-styles-api/0.21.0</code></a> · 1 paths · <code>figma-styles-api-openapi.yml</code></summary>

- `/v1/styles/{key}` — [`GET`](https://mocks.naftiko.net/rest/figma-styles-api/0.21.0/v1/styles/{key})

</details>

<details><summary><strong>figma-teams-api</strong> · v0.21.0 · <a href="https://mocks.naftiko.net/rest/figma-teams-api/0.21.0"><code>figma-teams-api/0.21.0</code></a> · 1 paths · <code>figma-teams-api-openapi.yml</code></summary>

- `/v2/teams/{team_id}/webhooks` — [`GET`](https://mocks.naftiko.net/rest/figma-teams-api/0.21.0/v2/teams/{team_id}/webhooks)

</details>

<details><summary><strong>openai-files-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/openai-files-api/1.0.0"><code>openai-files-api/1.0.0</code></a> · 3 paths · <code>files-openapi-original.yml</code></summary>

- `/files` — [`GET`](https://mocks.naftiko.net/rest/openai-files-api/1.0.0/files) `POST`
- `/files/{file_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-files-api/1.0.0/files/{file_id}) `DELETE`
- `/files/{file_id}/content` — [`GET`](https://mocks.naftiko.net/rest/openai-files-api/1.0.0/files/{file_id}/content)

</details>

<details><summary><strong>openai-fine-tuning-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/openai-fine-tuning-api/1.0.0"><code>openai-fine-tuning-api/1.0.0</code></a> · 4 paths · <code>fine-tuning-openapi-original.yml</code></summary>

- `/fine_tuning/jobs` — [`GET`](https://mocks.naftiko.net/rest/openai-fine-tuning-api/1.0.0/fine_tuning/jobs) `POST`
- `/fine_tuning/jobs/{fine_tuning_job_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-fine-tuning-api/1.0.0/fine_tuning/jobs/{fine_tuning_job_id})
- `/fine_tuning/jobs/{fine_tuning_job_id}/events` — [`GET`](https://mocks.naftiko.net/rest/openai-fine-tuning-api/1.0.0/fine_tuning/jobs/{fine_tuning_job_id}/events)
- `/fine_tuning/jobs/{fine_tuning_job_id}/cancel` — `POST`

</details>

<details><summary><strong>webflow-form-submissions-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-form-submissions-api/1.0.0"><code>webflow-form-submissions-api/1.0.0</code></a> · 3 paths · <code>form-submissions-openapi-original.yml</code></summary>

- `/form_submissions/{form_submission_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-form-submissions-api/1.0.0/form_submissions/{form_submission_id}) `PATCH` `DELETE`
- `/sites/{site_id}/form_submissions` — [`GET`](https://mocks.naftiko.net/rest/webflow-form-submissions-api/1.0.0/sites/{site_id}/form_submissions)
- `/sites/{site_id}/form_submissions/{form_submission_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-form-submissions-api/1.0.0/sites/{site_id}/form_submissions/{form_submission_id}) `PATCH` `DELETE`

</details>

<details><summary><strong>webflow-forms-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-forms-api/1.0.0"><code>webflow-forms-api/1.0.0</code></a> · 4 paths · <code>forms-openapi-original.yml</code></summary>

- `/sites/{site_id}/forms` — [`GET`](https://mocks.naftiko.net/rest/webflow-forms-api/1.0.0/sites/{site_id}/forms)
- `/forms/{form_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-forms-api/1.0.0/forms/{form_id})
- `/forms/{form_id}/submissions` — [`GET`](https://mocks.naftiko.net/rest/webflow-forms-api/1.0.0/forms/{form_id}/submissions)
- `/sites/{site_id}/forms/{form_id}/submissions` — [`GET`](https://mocks.naftiko.net/rest/webflow-forms-api/1.0.0/sites/{site_id}/forms/{form_id}/submissions)

</details>

<details><summary><strong>github-organizations-api</strong> · v1.1.4 · <a href="https://mocks.naftiko.net/rest/github-organizations-api/1.1.4"><code>github-organizations-api/1.1.4</code></a> · 104 paths · <code>github-organizations-openapi.yml</code></summary>

- `/organizations` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/organizations)
- `/organizations/{organization_id}/custom_roles` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/organizations/{organization_id}/custom_roles)
- `/orgs/{org}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}) `PATCH` `DELETE`
- `/orgs/{org}/actions/cache/usage` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/cache/usage)
- `/orgs/{org}/actions/cache/usage-by-repository` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/cache/usage-by-repository)
- `/orgs/{org}/actions/oidc/customization/sub` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/oidc/customization/sub) `PUT`
- `/orgs/{org}/actions/permissions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/permissions) `PUT`
- `/orgs/{org}/actions/permissions/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/permissions/repositories) `PUT`
- `/orgs/{org}/actions/permissions/repositories/{repository_id}` — `PUT` `DELETE`
- `/orgs/{org}/actions/permissions/selected-actions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/permissions/selected-actions) `PUT`
- `/orgs/{org}/actions/permissions/workflow` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/permissions/workflow) `PUT`
- `/orgs/{org}/actions/runner-groups` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runner-groups) `POST`
- `/orgs/{org}/actions/runner-groups/{runner_group_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runner-groups/{runner_group_id}) `PATCH` `DELETE`
- `/orgs/{org}/actions/runner-groups/{runner_group_id}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runner-groups/{runner_group_id}/repositories) `PUT`
- `/orgs/{org}/actions/runner-groups/{runner_group_id}/repositories/{repository_id}` — `PUT` `DELETE`
- `/orgs/{org}/actions/runner-groups/{runner_group_id}/runners` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runner-groups/{runner_group_id}/runners) `PUT`
- `/orgs/{org}/actions/runner-groups/{runner_group_id}/runners/{runner_id}` — `PUT` `DELETE`
- `/orgs/{org}/actions/runners` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runners)
- `/orgs/{org}/actions/runners/downloads` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runners/downloads)
- `/orgs/{org}/actions/runners/registration-token` — `POST`
- `/orgs/{org}/actions/runners/remove-token` — `POST`
- `/orgs/{org}/actions/runners/{runner_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runners/{runner_id}) `DELETE`
- `/orgs/{org}/actions/runners/{runner_id}/labels` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/runners/{runner_id}/labels) `POST` `PUT` `DELETE`
- `/orgs/{org}/actions/runners/{runner_id}/labels/{name}` — `DELETE`
- `/orgs/{org}/actions/secrets` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/secrets)
- `/orgs/{org}/actions/secrets/public-key` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/secrets/public-key)
- `/orgs/{org}/actions/secrets/{secret_name}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/secrets/{secret_name}) `PUT` `DELETE`
- `/orgs/{org}/actions/secrets/{secret_name}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/secrets/{secret_name}/repositories) `PUT`
- `/orgs/{org}/actions/secrets/{secret_name}/repositories/{repository_id}` — `PUT` `DELETE`
- `/orgs/{org}/actions/variables` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/variables) `POST`
- `/orgs/{org}/actions/variables/{name}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/variables/{name}) `PATCH` `DELETE`
- `/orgs/{org}/actions/variables/{name}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/actions/variables/{name}/repositories) `PUT`
- `/orgs/{org}/actions/variables/{name}/repositories/{repository_id}` — `PUT` `DELETE`
- `/orgs/{org}/announcement` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/announcement) `PATCH` `DELETE`
- `/orgs/{org}/audit-log` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/audit-log)
- `/orgs/{org}/code-scanning/alerts` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/code-scanning/alerts)
- `/orgs/{org}/custom-repository-roles` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/custom-repository-roles) `POST`
- `/orgs/{org}/custom-repository-roles/{role_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/custom-repository-roles/{role_id}) `PATCH` `DELETE`
- `/orgs/{org}/dependabot/alerts` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/dependabot/alerts)
- `/orgs/{org}/dependabot/secrets` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/dependabot/secrets)
- `/orgs/{org}/dependabot/secrets/public-key` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/dependabot/secrets/public-key)
- `/orgs/{org}/dependabot/secrets/{secret_name}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/dependabot/secrets/{secret_name}) `PUT` `DELETE`
- `/orgs/{org}/dependabot/secrets/{secret_name}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/dependabot/secrets/{secret_name}/repositories) `PUT`
- `/orgs/{org}/dependabot/secrets/{secret_name}/repositories/{repository_id}` — `PUT` `DELETE`
- `/orgs/{org}/docker/conflicts` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/docker/conflicts)
- `/orgs/{org}/events` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/events)
- `/orgs/{org}/external-group/{group_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/external-group/{group_id})
- `/orgs/{org}/external-groups` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/external-groups)
- `/orgs/{org}/hooks` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/hooks) `POST`
- `/orgs/{org}/hooks/{hook_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/hooks/{hook_id}) `PATCH` `DELETE`
- `/orgs/{org}/hooks/{hook_id}/config` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/hooks/{hook_id}/config) `PATCH`
- `/orgs/{org}/hooks/{hook_id}/deliveries` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/hooks/{hook_id}/deliveries)
- `/orgs/{org}/hooks/{hook_id}/deliveries/{delivery_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/hooks/{hook_id}/deliveries/{delivery_id})
- `/orgs/{org}/hooks/{hook_id}/deliveries/{delivery_id}/attempts` — `POST`
- `/orgs/{org}/hooks/{hook_id}/pings` — `POST`
- `/orgs/{org}/installation` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/installation)
- `/orgs/{org}/installations` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/installations)
- `/orgs/{org}/issues` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/issues)
- `/orgs/{org}/members` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/members)
- `/orgs/{org}/members/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/members/{username}) `DELETE`
- `/orgs/{org}/memberships/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/memberships/{username}) `PUT` `DELETE`
- `/orgs/{org}/migrations` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/migrations) `POST`
- `/orgs/{org}/migrations/{migration_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/migrations/{migration_id})
- `/orgs/{org}/migrations/{migration_id}/archive` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/migrations/{migration_id}/archive) `DELETE`
- `/orgs/{org}/migrations/{migration_id}/repos/{repo_name}/lock` — `DELETE`
- `/orgs/{org}/migrations/{migration_id}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/migrations/{migration_id}/repositories)
- `/orgs/{org}/outside_collaborators` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/outside_collaborators)
- `/orgs/{org}/outside_collaborators/{username}` — `PUT` `DELETE`
- `/orgs/{org}/packages` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/packages)
- `/orgs/{org}/packages/{package_type}/{package_name}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/packages/{package_type}/{package_name}) `DELETE`
- `/orgs/{org}/packages/{package_type}/{package_name}/restore` — `POST`
- `/orgs/{org}/packages/{package_type}/{package_name}/versions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/packages/{package_type}/{package_name}/versions)
- `/orgs/{org}/packages/{package_type}/{package_name}/versions/{package_version_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/packages/{package_type}/{package_name}/versions/{package_version_id}) `DELETE`
- `/orgs/{org}/packages/{package_type}/{package_name}/versions/{package_version_id}/restore` — `POST`
- `/orgs/{org}/pre-receive-hooks` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/pre-receive-hooks)
- `/orgs/{org}/pre-receive-hooks/{pre_receive_hook_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/pre-receive-hooks/{pre_receive_hook_id}) `PATCH` `DELETE`
- `/orgs/{org}/projects` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/projects) `POST`
- `/orgs/{org}/public_members` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/public_members)
- `/orgs/{org}/public_members/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/public_members/{username}) `PUT` `DELETE`
- `/orgs/{org}/repos` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/repos) `POST`
- `/orgs/{org}/repository-fine-grained-permissions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/repository-fine-grained-permissions)
- `/orgs/{org}/secret-scanning/alerts` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/secret-scanning/alerts)
- `/orgs/{org}/security-managers` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/security-managers)
- `/orgs/{org}/security-managers/teams/{team_slug}` — `PUT` `DELETE`
- `/orgs/{org}/settings/billing/advanced-security` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/settings/billing/advanced-security)
- `/orgs/{org}/teams` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams) `POST`
- `/orgs/{org}/teams/{team_slug}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}) `PATCH` `DELETE`
- `/orgs/{org}/teams/{team_slug}/discussions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions) `POST`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}) `PATCH` `DELETE`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments) `POST`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}) `PATCH` `DELETE`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}/reactions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}/reactions) `POST`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}/reactions/{reaction_id}` — `DELETE`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/reactions` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/reactions) `POST`
- `/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/reactions/{reaction_id}` — `DELETE`
- `/orgs/{org}/teams/{team_slug}/external-groups` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/external-groups) `PATCH` `DELETE`
- `/orgs/{org}/teams/{team_slug}/members` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/members)
- `/orgs/{org}/teams/{team_slug}/memberships/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/memberships/{username}) `PUT` `DELETE`
- `/orgs/{org}/teams/{team_slug}/projects` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/projects)
- `/orgs/{org}/teams/{team_slug}/projects/{project_id}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/projects/{project_id}) `PUT` `DELETE`
- `/orgs/{org}/teams/{team_slug}/repos` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/repos)
- `/orgs/{org}/teams/{team_slug}/repos/{owner}/{repo}` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/repos/{owner}/{repo}) `PUT` `DELETE`
- `/orgs/{org}/teams/{team_slug}/teams` — [`GET`](https://mocks.naftiko.net/rest/github-organizations-api/1.1.4/orgs/{org}/teams/{team_slug}/teams)
- `/orgs/{org}/{security_product}/{enablement}` — `POST`

</details>

<details><summary><strong>github-projects-api</strong> · v1.1.4 · <a href="https://mocks.naftiko.net/rest/github-projects-api/1.1.4"><code>github-projects-api/1.1.4</code></a> · 10 paths · <code>github-projects-openapi.yml</code></summary>

- `/projects/columns/cards/{card_id}` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/columns/cards/{card_id}) `PATCH` `DELETE`
- `/projects/columns/cards/{card_id}/moves` — `POST`
- `/projects/columns/{column_id}` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/columns/{column_id}) `PATCH` `DELETE`
- `/projects/columns/{column_id}/cards` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/columns/{column_id}/cards) `POST`
- `/projects/columns/{column_id}/moves` — `POST`
- `/projects/{project_id}` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/{project_id}) `PATCH` `DELETE`
- `/projects/{project_id}/collaborators` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/{project_id}/collaborators)
- `/projects/{project_id}/collaborators/{username}` — `PUT` `DELETE`
- `/projects/{project_id}/collaborators/{username}/permission` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/{project_id}/collaborators/{username}/permission)
- `/projects/{project_id}/columns` — [`GET`](https://mocks.naftiko.net/rest/github-projects-api/1.1.4/projects/{project_id}/columns) `POST`

</details>

<details><summary><strong>github-repos-api</strong> · v1.1.4 · <a href="https://mocks.naftiko.net/rest/github-repos-api/1.1.4"><code>github-repos-api/1.1.4</code></a> · 111 paths · <code>github-repos-api-openapi.yml</code></summary>

- `/repos/{owner}/{repo}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/assignees` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/assignees)
- `/repos/{owner}/{repo}/assignees/{assignee}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/assignees/{assignee})
- `/repos/{owner}/{repo}/check-runs` — `POST`
- `/repos/{owner}/{repo}/check-runs/{check_run_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/check-runs/{check_run_id}) `PATCH`
- `/repos/{owner}/{repo}/check-runs/{check_run_id}/annotations` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/check-runs/{check_run_id}/annotations)
- `/repos/{owner}/{repo}/check-runs/{check_run_id}/rerequest` — `POST`
- `/repos/{owner}/{repo}/check-suites` — `POST`
- `/repos/{owner}/{repo}/check-suites/preferences` — `PATCH`
- `/repos/{owner}/{repo}/check-suites/{check_suite_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/check-suites/{check_suite_id})
- `/repos/{owner}/{repo}/check-suites/{check_suite_id}/check-runs` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/check-suites/{check_suite_id}/check-runs)
- `/repos/{owner}/{repo}/check-suites/{check_suite_id}/rerequest` — `POST`
- `/repos/{owner}/{repo}/codeowners/errors` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/codeowners/errors)
- `/repos/{owner}/{repo}/comments` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/comments)
- `/repos/{owner}/{repo}/comments/{comment_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/comments/{comment_id}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/comments/{comment_id}/reactions` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/comments/{comment_id}/reactions) `POST`
- `/repos/{owner}/{repo}/comments/{comment_id}/reactions/{reaction_id}` — `DELETE`
- `/repos/{owner}/{repo}/commits` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits)
- `/repos/{owner}/{repo}/commits/{commit_sha}/branches-where-head` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{commit_sha}/branches-where-head)
- `/repos/{owner}/{repo}/commits/{commit_sha}/comments` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{commit_sha}/comments) `POST`
- `/repos/{owner}/{repo}/commits/{commit_sha}/pulls` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{commit_sha}/pulls)
- `/repos/{owner}/{repo}/commits/{ref}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{ref})
- `/repos/{owner}/{repo}/commits/{ref}/check-runs` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{ref}/check-runs)
- `/repos/{owner}/{repo}/commits/{ref}/check-suites` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{ref}/check-suites)
- `/repos/{owner}/{repo}/commits/{ref}/status` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{ref}/status)
- `/repos/{owner}/{repo}/commits/{ref}/statuses` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/commits/{ref}/statuses)
- `/repos/{owner}/{repo}/compare/{basehead}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/compare/{basehead})
- `/repos/{owner}/{repo}/contents/{path}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/contents/{path}) `PUT` `DELETE`
- `/repos/{owner}/{repo}/contributors` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/contributors)
- `/repos/{owner}/{repo}/dependency-graph/compare/{basehead}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/dependency-graph/compare/{basehead})
- `/repos/{owner}/{repo}/dependency-graph/sbom` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/dependency-graph/sbom)
- `/repos/{owner}/{repo}/dependency-graph/snapshots` — `POST`
- `/repos/{owner}/{repo}/deployments` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/deployments) `POST`
- `/repos/{owner}/{repo}/deployments/{deployment_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/deployments/{deployment_id}) `DELETE`
- `/repos/{owner}/{repo}/deployments/{deployment_id}/statuses` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/deployments/{deployment_id}/statuses) `POST`
- `/repos/{owner}/{repo}/deployments/{deployment_id}/statuses/{status_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/deployments/{deployment_id}/statuses/{status_id})
- `/repos/{owner}/{repo}/dispatches` — `POST`
- `/repos/{owner}/{repo}/environments` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments)
- `/repos/{owner}/{repo}/environments/{environment_name}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}) `PUT` `DELETE`
- `/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies) `POST`
- `/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies/{branch_policy_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies/{branch_policy_id}) `PUT` `DELETE`
- `/repos/{owner}/{repo}/environments/{environment_name}/secrets` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/secrets)
- `/repos/{owner}/{repo}/environments/{environment_name}/secrets/public-key` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/secrets/public-key)
- `/repos/{owner}/{repo}/environments/{environment_name}/secrets/{secret_name}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/secrets/{secret_name}) `PUT` `DELETE`
- `/repos/{owner}/{repo}/environments/{environment_name}/variables` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/variables) `POST`
- `/repos/{owner}/{repo}/environments/{environment_name}/variables/{name}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/environments/{environment_name}/variables/{name}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/events` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/events)
- `/repos/{owner}/{repo}/forks` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/forks) `POST`
- `/repos/{owner}/{repo}/git/blobs` — `POST`
- `/repos/{owner}/{repo}/git/blobs/{file_sha}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/blobs/{file_sha})
- `/repos/{owner}/{repo}/git/commits` — `POST`
- `/repos/{owner}/{repo}/git/commits/{commit_sha}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/commits/{commit_sha})
- `/repos/{owner}/{repo}/git/matching-refs/{ref}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/matching-refs/{ref})
- `/repos/{owner}/{repo}/git/ref/{ref}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/ref/{ref})
- `/repos/{owner}/{repo}/git/refs` — `POST`
- `/repos/{owner}/{repo}/git/refs/{ref}` — `PATCH` `DELETE`
- `/repos/{owner}/{repo}/git/tags` — `POST`
- `/repos/{owner}/{repo}/git/tags/{tag_sha}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/tags/{tag_sha})
- `/repos/{owner}/{repo}/git/trees` — `POST`
- `/repos/{owner}/{repo}/git/trees/{tree_sha}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/git/trees/{tree_sha})
- `/repos/{owner}/{repo}/installation` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/installation)
- `/repos/{owner}/{repo}/keys` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/keys) `POST`
- `/repos/{owner}/{repo}/keys/{key_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/keys/{key_id}) `DELETE`
- `/repos/{owner}/{repo}/labels` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/labels) `POST`
- `/repos/{owner}/{repo}/labels/{name}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/labels/{name}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/languages` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/languages)
- `/repos/{owner}/{repo}/lfs` — `PUT` `DELETE`
- `/repos/{owner}/{repo}/license` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/license)
- `/repos/{owner}/{repo}/merge-upstream` — `POST`
- `/repos/{owner}/{repo}/merges` — `POST`
- `/repos/{owner}/{repo}/milestones` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/milestones) `POST`
- `/repos/{owner}/{repo}/milestones/{milestone_number}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/milestones/{milestone_number}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/milestones/{milestone_number}/labels` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/milestones/{milestone_number}/labels)
- `/repos/{owner}/{repo}/notifications` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/notifications) `PUT`
- `/repos/{owner}/{repo}/pages` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/pages) `POST` `PUT` `DELETE`
- `/repos/{owner}/{repo}/pages/builds` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/pages/builds) `POST`
- `/repos/{owner}/{repo}/pages/builds/latest` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/pages/builds/latest)
- `/repos/{owner}/{repo}/pages/builds/{build_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/pages/builds/{build_id})
- `/repos/{owner}/{repo}/pages/deployments` — `POST`
- `/repos/{owner}/{repo}/readme` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/readme)
- `/repos/{owner}/{repo}/readme/{dir}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/readme/{dir})
- `/repos/{owner}/{repo}/releases` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases) `POST`
- `/repos/{owner}/{repo}/releases/assets/{asset_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/assets/{asset_id}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/releases/generate-notes` — `POST`
- `/repos/{owner}/{repo}/releases/latest` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/latest)
- `/repos/{owner}/{repo}/releases/tags/{tag}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/tags/{tag})
- `/repos/{owner}/{repo}/releases/{release_id}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/{release_id}) `PATCH` `DELETE`
- `/repos/{owner}/{repo}/releases/{release_id}/assets` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/{release_id}/assets) `POST`
- `/repos/{owner}/{repo}/releases/{release_id}/reactions` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/releases/{release_id}/reactions) `POST`
- `/repos/{owner}/{repo}/releases/{release_id}/reactions/{reaction_id}` — `DELETE`
- `/repos/{owner}/{repo}/replicas/caches` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/replicas/caches)
- `/repos/{owner}/{repo}/secret-scanning/alerts` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/secret-scanning/alerts)
- `/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}) `PATCH`
- `/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}/locations` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}/locations)
- `/repos/{owner}/{repo}/stargazers` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stargazers)
- `/repos/{owner}/{repo}/stats/code_frequency` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stats/code_frequency)
- `/repos/{owner}/{repo}/stats/commit_activity` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stats/commit_activity)
- `/repos/{owner}/{repo}/stats/contributors` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stats/contributors)
- `/repos/{owner}/{repo}/stats/participation` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stats/participation)
- `/repos/{owner}/{repo}/stats/punch_card` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/stats/punch_card)
- `/repos/{owner}/{repo}/statuses/{sha}` — `POST`
- `/repos/{owner}/{repo}/subscribers` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/subscribers)
- `/repos/{owner}/{repo}/tarball/{ref}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/tarball/{ref})
- `/repos/{owner}/{repo}/teams` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/teams)
- `/repos/{owner}/{repo}/topics` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/topics) `PUT`
- `/repos/{owner}/{repo}/transfer` — `POST`
- `/repos/{owner}/{repo}/vulnerability-alerts` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/vulnerability-alerts) `PUT` `DELETE`
- `/repos/{owner}/{repo}/zipball/{ref}` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repos/{owner}/{repo}/zipball/{ref})
- `/repos/{template_owner}/{template_repo}/generate` — `POST`
- `/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/repositories)
- `/search/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-repos-api/1.1.4/search/repositories)

</details>

<details><summary><strong>github-search-api</strong> · v1.1.4 · <a href="https://mocks.naftiko.net/rest/github-search-api/1.1.4"><code>github-search-api/1.1.4</code></a> · 7 paths · <code>github-search-api-openapi.yml</code></summary>

- `/search/code` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/code)
- `/search/commits` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/commits)
- `/search/issues` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/issues)
- `/search/labels` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/labels)
- `/search/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/repositories)
- `/search/topics` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/topics)
- `/search/users` — [`GET`](https://mocks.naftiko.net/rest/github-search-api/1.1.4/search/users)

</details>

<details><summary><strong>github-users-api</strong> · v1.1.4 · <a href="https://mocks.naftiko.net/rest/github-users-api/1.1.4"><code>github-users-api/1.1.4</code></a> · 77 paths · <code>github-users-api-openapi.yml</code></summary>

- `/admin/ldap/users/{username}/mapping` — `PATCH`
- `/admin/ldap/users/{username}/sync` — `POST`
- `/admin/users` — `POST`
- `/admin/users/{username}` — `PATCH` `DELETE`
- `/admin/users/{username}/authorizations` — `POST` `DELETE`
- `/enterprise/stats/users` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/enterprise/stats/users)
- `/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/users` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/users) `POST` `PUT` `DELETE`
- `/search/users` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/search/users)
- `/user` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user) `PATCH`
- `/user/docker/conflicts` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/docker/conflicts)
- `/user/emails` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/emails) `POST` `DELETE`
- `/user/followers` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/followers)
- `/user/following` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/following)
- `/user/following/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/following/{username}) `PUT` `DELETE`
- `/user/gpg_keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/gpg_keys) `POST`
- `/user/gpg_keys/{gpg_key_id}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/gpg_keys/{gpg_key_id}) `DELETE`
- `/user/installations` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/installations)
- `/user/installations/{installation_id}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/installations/{installation_id}/repositories)
- `/user/installations/{installation_id}/repositories/{repository_id}` — `PUT` `DELETE`
- `/user/issues` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/issues)
- `/user/keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/keys) `POST`
- `/user/keys/{key_id}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/keys/{key_id}) `DELETE`
- `/user/memberships/orgs` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/memberships/orgs)
- `/user/memberships/orgs/{org}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/memberships/orgs/{org}) `PATCH`
- `/user/migrations` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/migrations) `POST`
- `/user/migrations/{migration_id}/archive` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/migrations/{migration_id}/archive)
- `/user/migrations/{migration_id}/repositories` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/migrations/{migration_id}/repositories)
- `/user/orgs` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/orgs)
- `/user/packages` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/packages)
- `/user/packages/{package_type}/{package_name}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/packages/{package_type}/{package_name}) `DELETE`
- `/user/packages/{package_type}/{package_name}/restore` — `POST`
- `/user/packages/{package_type}/{package_name}/versions` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/packages/{package_type}/{package_name}/versions)
- `/user/packages/{package_type}/{package_name}/versions/{package_version_id}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/packages/{package_type}/{package_name}/versions/{package_version_id}) `DELETE`
- `/user/packages/{package_type}/{package_name}/versions/{package_version_id}/restore` — `POST`
- `/user/projects` — `POST`
- `/user/public_emails` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/public_emails)
- `/user/repos` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/repos) `POST`
- `/user/repository_invitations` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/repository_invitations)
- `/user/repository_invitations/{invitation_id}` — `PATCH` `DELETE`
- `/user/social_accounts` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/social_accounts) `POST` `DELETE`
- `/user/ssh_signing_keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/ssh_signing_keys) `POST`
- `/user/ssh_signing_keys/{ssh_signing_key_id}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/ssh_signing_keys/{ssh_signing_key_id}) `DELETE`
- `/user/starred` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/starred)
- `/user/starred/{owner}/{repo}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/starred/{owner}/{repo}) `PUT` `DELETE`
- `/user/subscriptions` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/subscriptions)
- `/user/teams` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/user/teams)
- `/users` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users)
- `/users/{username}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username})
- `/users/{username}/docker/conflicts` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/docker/conflicts)
- `/users/{username}/events` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/events)
- `/users/{username}/events/orgs/{org}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/events/orgs/{org})
- `/users/{username}/events/public` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/events/public)
- `/users/{username}/followers` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/followers)
- `/users/{username}/following` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/following)
- `/users/{username}/following/{target_user}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/following/{target_user})
- `/users/{username}/gists` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/gists)
- `/users/{username}/gpg_keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/gpg_keys)
- `/users/{username}/hovercard` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/hovercard)
- `/users/{username}/installation` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/installation)
- `/users/{username}/keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/keys)
- `/users/{username}/orgs` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/orgs)
- `/users/{username}/packages` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/packages)
- `/users/{username}/packages/{package_type}/{package_name}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/packages/{package_type}/{package_name}) `DELETE`
- `/users/{username}/packages/{package_type}/{package_name}/restore` — `POST`
- `/users/{username}/packages/{package_type}/{package_name}/versions` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/packages/{package_type}/{package_name}/versions)
- `/users/{username}/packages/{package_type}/{package_name}/versions/{package_version_id}` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/packages/{package_type}/{package_name}/versions/{package_version_id}) `DELETE`
- `/users/{username}/packages/{package_type}/{package_name}/versions/{package_version_id}/restore` — `POST`
- `/users/{username}/projects` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/projects)
- `/users/{username}/received_events` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/received_events)
- `/users/{username}/received_events/public` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/received_events/public)
- `/users/{username}/repos` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/repos)
- `/users/{username}/site_admin` — `PUT` `DELETE`
- `/users/{username}/social_accounts` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/social_accounts)
- `/users/{username}/ssh_signing_keys` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/ssh_signing_keys)
- `/users/{username}/starred` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/starred)
- `/users/{username}/subscriptions` — [`GET`](https://mocks.naftiko.net/rest/github-users-api/1.1.4/users/{username}/subscriptions)
- `/users/{username}/suspended` — `PUT` `DELETE`

</details>

<details><summary><strong>google-calendar-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/google-calendar-api/1.0.0"><code>google-calendar-api/1.0.0</code></a> · 23 paths · <code>google-calendar-api-openapi.yml</code></summary>

- `/calendars/{calendarId}/acl/{ruleId}` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}/acl/{ruleId}) `PUT` `PATCH` `DELETE`
- `/calendars/{calendarId}/acl` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}/acl) `POST`
- `/calendars/{calendarId}/acl/watch` — `POST`
- `/calendars/{calendarId}/events/{eventId}` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}/events/{eventId}) `PUT` `PATCH` `DELETE`
- `/calendars/{calendarId}/events/{eventId}/instances` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}/events/{eventId}/instances)
- `/calendars/{calendarId}/events/{eventId}/move` — `POST`
- `/calendars/{calendarId}/events` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}/events) `POST`
- `/calendars/{calendarId}/events/import` — `POST`
- `/calendars/{calendarId}/events/quickAdd` — `POST`
- `/calendars/{calendarId}/events/watch` — `POST`
- `/calendars/{calendarId}` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/calendars/{calendarId}) `PUT` `PATCH` `DELETE`
- `/calendars/{calendarId}/clear` — `POST`
- `/calendars` — `POST`
- `/users/me/calendarList/{calendarId}` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/users/me/calendarList/{calendarId}) `PUT` `PATCH` `DELETE`
- `/users/me/calendarList` — `POST`
- `/users/{userId}/calendarList` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/users/{userId}/calendarList)
- `/users/me/calendarList/watch` — `POST`
- `/users/me/settings` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/users/me/settings)
- `/users/me/settings/{setting}` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/users/me/settings/{setting})
- `/users/me/settings/watch` — `POST`
- `/channels/stop` — `POST`
- `/colors` — [`GET`](https://mocks.naftiko.net/rest/google-calendar-api/1.0.0/colors)
- `/freeBusy` — `POST`

</details>

<details><summary><strong>google-docs-api</strong> · vv1 · <a href="https://mocks.naftiko.net/rest/google-docs-api/v1"><code>google-docs-api/v1</code></a> · 3 paths · <code>google-docs-api-openapi.yml</code></summary>

- `/v1/documents` — `POST`
- `/v1/documents/{documentId}` — [`GET`](https://mocks.naftiko.net/rest/google-docs-api/v1/v1/documents/{documentId})
- `/v1/documents/{documentId}:batchUpdate` — `POST`

</details>

<details><summary><strong>google-drive-activity-api</strong> · vv2 · <a href="https://mocks.naftiko.net/rest/google-drive-activity-api/v2"><code>google-drive-activity-api/v2</code></a> · 1 paths · <code>google-drive-activity-api-openapi.yml</code></summary>

- `/v2/activity:query` — `POST`

</details>

<details><summary><strong>google-drive-api</strong> · vv3 · <a href="https://mocks.naftiko.net/rest/google-drive-api/v3"><code>google-drive-api/v3</code></a> · 30 paths · <code>google-drive-api-openapi.yml</code></summary>

- `/about` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/about)
- `/apps` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/apps)
- `/apps/{appId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/apps/{appId})
- `/changes` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/changes)
- `/changes/startPageToken` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/changes/startPageToken)
- `/changes/watch` — `POST`
- `/channels/stop` — `POST`
- `/drives` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/drives) `POST`
- `/drives/{driveId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/drives/{driveId}) `PATCH` `DELETE`
- `/drives/{driveId}/hide` — `POST`
- `/drives/{driveId}/unhide` — `POST`
- `/files` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files) `POST`
- `/files/generateIds` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/generateIds)
- `/files/trash` — `DELETE`
- `/files/{fileId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}) `PATCH` `DELETE`
- `/files/{fileId}/comments` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/comments) `POST`
- `/files/{fileId}/comments/{commentId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/comments/{commentId}) `PATCH` `DELETE`
- `/files/{fileId}/comments/{commentId}/replies` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/comments/{commentId}/replies) `POST`
- `/files/{fileId}/comments/{commentId}/replies/{replyId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/comments/{commentId}/replies/{replyId}) `PATCH` `DELETE`
- `/files/{fileId}/copy` — `POST`
- `/files/{fileId}/export` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/export)
- `/files/{fileId}/listLabels` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/listLabels)
- `/files/{fileId}/modifyLabels` — `POST`
- `/files/{fileId}/permissions` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/permissions) `POST`
- `/files/{fileId}/permissions/{permissionId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/permissions/{permissionId}) `PATCH` `DELETE`
- `/files/{fileId}/revisions` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/revisions)
- `/files/{fileId}/revisions/{revisionId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/files/{fileId}/revisions/{revisionId}) `PATCH` `DELETE`
- `/files/{fileId}/watch` — `POST`
- `/teamdrives` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/teamdrives) `POST`
- `/teamdrives/{teamDriveId}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-api/v3/teamdrives/{teamDriveId}) `PATCH` `DELETE`

</details>

<details><summary><strong>google-drive-labels-api</strong> · vv2 · <a href="https://mocks.naftiko.net/rest/google-drive-labels-api/v2"><code>google-drive-labels-api/v2</code></a> · 12 paths · <code>google-drive-labels-api-openapi.yml</code></summary>

- `/v2/labels` — [`GET`](https://mocks.naftiko.net/rest/google-drive-labels-api/v2/v2/labels) `POST`
- `/v2/limits/label` — [`GET`](https://mocks.naftiko.net/rest/google-drive-labels-api/v2/v2/limits/label)
- `/v2/{name}` — [`GET`](https://mocks.naftiko.net/rest/google-drive-labels-api/v2/v2/{name}) `DELETE`
- `/v2/{name}:delta` — `POST`
- `/v2/{name}:disable` — `POST`
- `/v2/{name}:enable` — `POST`
- `/v2/{name}:publish` — `POST`
- `/v2/{name}:updateLabelCopyMode` — `POST`
- `/v2/{parent}/locks` — [`GET`](https://mocks.naftiko.net/rest/google-drive-labels-api/v2/v2/{parent}/locks)
- `/v2/{parent}/permissions` — [`GET`](https://mocks.naftiko.net/rest/google-drive-labels-api/v2/v2/{parent}/permissions) `POST` `PATCH`
- `/v2/{parent}/permissions:batchDelete` — `POST`
- `/v2/{parent}/permissions:batchUpdate` — `POST`

</details>

<details><summary><strong>gemini-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/gemini-api/1.0.0"><code>gemini-api/1.0.0</code></a> · 7 paths · <code>google-gemini-api-openapi.yml</code></summary>

- `/files` — `POST`
- `/files/{name}` — [`GET`](https://mocks.naftiko.net/rest/gemini-api/1.0.0/files/{name})
- `/models/{model}:countTokens` — `POST`
- `/models/{model}:generateContent` — `POST`
- `/models/{ttsModel}:generateContent` — `POST`
- `/models/{model}:streamGenerateContent` — `POST`
- `/models/{imageModel}:generateContent` — `POST`

</details>

<details><summary><strong>google-gmail-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/google-gmail-api/1.0.0"><code>google-gmail-api/1.0.0</code></a> · 48 paths · <code>google-gmail-api-openapi.yml</code></summary>

- `/gmail/v1/users/{userId}/profile` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/profile)
- `/gmail/v1/users/{userId}/watch` — `POST`
- `/gmail/v1/users/{userId}/stop` — `POST`
- `/gmail/v1/users/{userId}/drafts/send` — `POST`
- `/gmail/v1/users/{userId}/drafts/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/drafts/{id}) `PUT` `DELETE`
- `/gmail/v1/users/{userId}/drafts` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/drafts) `POST`
- `/gmail/v1/users/{userId}/history` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/history)
- `/gmail/v1/users/{userId}/messages/{id}/trash` — `POST`
- `/gmail/v1/users/{userId}/messages/{id}/untrash` — `POST`
- `/gmail/v1/users/{userId}/messages/{id}/modify` — `POST`
- `/gmail/v1/users/{userId}/messages/batchDelete` — `POST`
- `/gmail/v1/users/{userId}/messages/import` — `POST`
- `/gmail/v1/users/{userId}/messages/send` — `POST`
- `/gmail/v1/users/{userId}/messages/batchModify` — `POST`
- `/gmail/v1/users/{userId}/messages` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/messages) `POST`
- `/gmail/v1/users/{userId}/messages/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/messages/{id}) `DELETE`
- `/gmail/v1/users/{userId}/messages/{messageId}/attachments/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/messages/{messageId}/attachments/{id})
- `/gmail/v1/users/{userId}/labels` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/labels) `POST`
- `/gmail/v1/users/{userId}/labels/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/labels/{id}) `PUT` `PATCH` `DELETE`
- `/gmail/v1/users/{userId}/threads/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/threads/{id}) `DELETE`
- `/gmail/v1/users/{userId}/threads/{id}/modify` — `POST`
- `/gmail/v1/users/{userId}/threads/{id}/trash` — `POST`
- `/gmail/v1/users/{userId}/threads` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/threads)
- `/gmail/v1/users/{userId}/settings/imap` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/imap) `PUT`
- `/gmail/v1/users/{userId}/settings/pop` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/pop) `PUT`
- `/gmail/v1/users/{userId}/settings/vacation` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/vacation) `PUT`
- `/gmail/v1/users/{userId}/settings/language` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/language) `PUT`
- `/gmail/v1/users/{userId}/settings/autoForwarding` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/autoForwarding) `PUT`
- `/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/smimeInfo/{id}/setDefault` — `POST`
- `/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/smimeInfo/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/smimeInfo/{id}) `DELETE`
- `/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/smimeInfo` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/smimeInfo) `POST`
- `/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}/verify` — `POST`
- `/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/sendAs/{sendAsEmail}) `PUT` `PATCH` `DELETE`
- `/gmail/v1/users/{userId}/settings/sendAs` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/sendAs) `POST`
- `/gmail/v1/users/{userId}/settings/cse/keypairs/{keyPairId}:enable` — `POST`
- `/gmail/v1/users/{userId}/settings/cse/keypairs/{keyPairId}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/cse/keypairs/{keyPairId})
- `/gmail/v1/users/{userId}/settings/cse/keypairs/{keyPairId}:disable` — `POST`
- `/gmail/v1/users/{userId}/settings/cse/keypairs/{keyPairId}:obliterate` — `POST`
- `/gmail/v1/users/{userId}/settings/cse/keypairs` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/cse/keypairs) `POST`
- `/gmail/v1/users/{userId}/settings/cse/identities` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/cse/identities) `POST`
- `/gmail/v1/users/{userId}/settings/cse/identities/{emailAddress}` — `PATCH`
- `/gmail/v1/users/{userId}/settings/cse/identities/{cseEmailAddress}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/cse/identities/{cseEmailAddress}) `DELETE`
- `/gmail/v1/users/{userId}/settings/filters/{id}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/filters/{id}) `DELETE`
- `/gmail/v1/users/{userId}/settings/filters` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/filters) `POST`
- `/gmail/v1/users/{userId}/settings/forwardingAddresses/{forwardingEmail}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/forwardingAddresses/{forwardingEmail}) `DELETE`
- `/gmail/v1/users/{userId}/settings/forwardingAddresses` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/forwardingAddresses) `POST`
- `/gmail/v1/users/{userId}/settings/delegates/{delegateEmail}` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/delegates/{delegateEmail}) `DELETE`
- `/gmail/v1/users/{userId}/settings/delegates` — [`GET`](https://mocks.naftiko.net/rest/google-gmail-api/1.0.0/gmail/v1/users/{userId}/settings/delegates) `POST`

</details>

<details><summary><strong>google-sheets-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/google-sheets-api/1.0.0"><code>google-sheets-api/1.0.0</code></a> · 16 paths · <code>google-sheets-api-openapi.yml</code></summary>

- `/v4/spreadsheets/{spreadsheetId}/values/{range}` — [`GET`](https://mocks.naftiko.net/rest/google-sheets-api/1.0.0/v4/spreadsheets/{spreadsheetId}/values/{range}) `PUT`
- `/v4/spreadsheets/{spreadsheetId}/values/{range}:append` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values/{range}:clear` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values:batchGet` — [`GET`](https://mocks.naftiko.net/rest/google-sheets-api/1.0.0/v4/spreadsheets/{spreadsheetId}/values:batchGet)
- `/v4/spreadsheets/{spreadsheetId}/values:batchUpdate` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values:batchClear` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values:batchClearByDataFilter` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values:batchGetByDataFilter` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/values:batchUpdateByDataFilter` — `POST`
- `/v4/spreadsheets` — `POST`
- `/v4/spreadsheets/{spreadsheetId}` — [`GET`](https://mocks.naftiko.net/rest/google-sheets-api/1.0.0/v4/spreadsheets/{spreadsheetId})
- `/v4/spreadsheets/{spreadsheetId}:batchUpdate` — `POST`
- `/v4/spreadsheets/{spreadsheetId}:getByDataFilter` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/sheets/{sheetId}:copyTo` — `POST`
- `/v4/spreadsheets/{spreadsheetId}/developerMetadata/{metadataId}` — [`GET`](https://mocks.naftiko.net/rest/google-sheets-api/1.0.0/v4/spreadsheets/{spreadsheetId}/developerMetadata/{metadataId})
- `/v4/spreadsheets/{spreadsheetId}/developerMetadata:search` — `POST`

</details>

<details><summary><strong>hubspot-analytics-events-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-analytics-events-api/3.0.0"><code>hubspot-analytics-events-api/3.0.0</code></a> · 2 paths · <code>hubspot-analytics-events-api-openapi.yml</code></summary>

- `/events/v3/events` — [`GET`](https://mocks.naftiko.net/rest/hubspot-analytics-events-api/3.0.0/events/v3/events)
- `/events/v3/events/event-types` — [`GET`](https://mocks.naftiko.net/rest/hubspot-analytics-events-api/3.0.0/events/v3/events/event-types)

</details>

<details><summary><strong>hubspot-blog-authors-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-blog-authors-api/3.0.0"><code>hubspot-blog-authors-api/3.0.0</code></a> · 10 paths · <code>hubspot-authors-api-openapi.yml</code></summary>

- `/cms/v3/blogs/authors` — [`GET`](https://mocks.naftiko.net/rest/hubspot-blog-authors-api/3.0.0/cms/v3/blogs/authors) `POST`
- `/cms/v3/blogs/authors/{objectId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-blog-authors-api/3.0.0/cms/v3/blogs/authors/{objectId}) `PATCH` `DELETE`
- `/cms/v3/blogs/authors/batch/read` — `POST`
- `/cms/v3/blogs/authors/batch/create` — `POST`
- `/cms/v3/blogs/authors/batch/update` — `POST`
- `/cms/v3/blogs/authors/batch/archive` — `POST`
- `/cms/v3/blogs/authors/multi-language/detach-from-lang-group` — `POST`
- `/cms/v3/blogs/authors/multi-language/set-new-lang-primary` — `PUT`
- `/cms/v3/blogs/authors/multi-language/attach-to-lang-group` — `POST`
- `/cms/v3/blogs/authors/multi-language/create-language-variation` — `POST`

</details>

<details><summary><strong>hubspot-blog-posts-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-blog-posts-api/3.0.0"><code>hubspot-blog-posts-api/3.0.0</code></a> · 16 paths · <code>hubspot-blog-posts-api-openapi.yml</code></summary>

- `/cms/v3/blogs/posts` — [`GET`](https://mocks.naftiko.net/rest/hubspot-blog-posts-api/3.0.0/cms/v3/blogs/posts) `POST`
- `/cms/v3/blogs/posts/{objectId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-blog-posts-api/3.0.0/cms/v3/blogs/posts/{objectId}) `PATCH` `DELETE`
- `/cms/v3/blogs/posts/schedule` — `POST`
- `/cms/v3/blogs/posts/clone` — `POST`
- `/cms/v3/blogs/posts/{objectId}/draft/push-live` — `POST`
- `/cms/v3/blogs/posts/{objectId}/draft/reset` — `POST`
- `/cms/v3/blogs/posts/{objectId}/revisions` — [`GET`](https://mocks.naftiko.net/rest/hubspot-blog-posts-api/3.0.0/cms/v3/blogs/posts/{objectId}/revisions)
- `/cms/v3/blogs/posts/{objectId}/revisions/{revisionId}/restore` — `POST`
- `/cms/v3/blogs/posts/batch/read` — `POST`
- `/cms/v3/blogs/posts/batch/create` — `POST`
- `/cms/v3/blogs/posts/batch/update` — `POST`
- `/cms/v3/blogs/posts/batch/archive` — `POST`
- `/cms/v3/blogs/posts/multi-language/detach-from-lang-group` — `POST`
- `/cms/v3/blogs/posts/multi-language/set-new-lang-primary` — `PUT`
- `/cms/v3/blogs/posts/multi-language/attach-to-lang-group` — `POST`
- `/cms/v3/blogs/posts/multi-language/create-language-variation` — `POST`

</details>

<details><summary><strong>hubspot-commerce-payments-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-commerce-payments-api/3.0.0"><code>hubspot-commerce-payments-api/3.0.0</code></a> · 7 paths · <code>hubspot-commerce-payments-api-openapi.yml</code></summary>

- `/crm/v3/objects/commerce_payments/batch/read` — `POST`
- `/crm/v3/objects/commerce_payments/batch/archive` — `POST`
- `/crm/v3/objects/commerce_payments/batch/create` — `POST`
- `/crm/v3/objects/commerce_payments/batch/update` — `POST`
- `/crm/v3/objects/commerce_payments` — [`GET`](https://mocks.naftiko.net/rest/hubspot-commerce-payments-api/3.0.0/crm/v3/objects/commerce_payments) `POST`
- `/crm/v3/objects/commerce_payments/{commercePaymentId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-commerce-payments-api/3.0.0/crm/v3/objects/commerce_payments/{commercePaymentId}) `PATCH` `DELETE`
- `/crm/v3/objects/commerce_payments/search` — `POST`

</details>

<details><summary><strong>hubspot-conversations-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0"><code>hubspot-conversations-api/3.0.0</code></a> · 9 paths · <code>hubspot-conversations-api-openapi.yml</code></summary>

- `/conversations/v3/conversations/inboxes` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/inboxes)
- `/conversations/v3/conversations/inboxes/{inboxId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/inboxes/{inboxId})
- `/conversations/v3/conversations/threads` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/threads)
- `/conversations/v3/conversations/threads/{threadId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/threads/{threadId}) `PATCH` `DELETE`
- `/conversations/v3/conversations/threads/{threadId}/messages` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/threads/{threadId}/messages) `POST`
- `/conversations/v3/conversations/threads/{threadId}/messages/{messageId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/threads/{threadId}/messages/{messageId})
- `/conversations/v3/conversations/channels` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/channels)
- `/conversations/v3/conversations/actors` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/actors)
- `/conversations/v3/conversations/actors/{actorId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-conversations-api/3.0.0/conversations/v3/conversations/actors/{actorId})

</details>

<details><summary><strong>hubspot-crm-associations-api</strong> · v4.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-crm-associations-api/4.0.0"><code>hubspot-crm-associations-api/4.0.0</code></a> · 8 paths · <code>hubspot-crm-associations-api-openapi.yml</code></summary>

- `/crm/v4/objects/{fromObjectType}/{fromObjectId}/associations/{toObjectType}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-associations-api/4.0.0/crm/v4/objects/{fromObjectType}/{fromObjectId}/associations/{toObjectType}) `PUT`
- `/crm/v4/objects/{fromObjectType}/{fromObjectId}/associations/{toObjectType}/{toObjectId}` — `DELETE`
- `/crm/v4/associations/{fromObjectType}/{toObjectType}/batch/read` — `POST`
- `/crm/v4/associations/{fromObjectType}/{toObjectType}/batch/create` — `POST`
- `/crm/v4/associations/{fromObjectType}/{toObjectType}/batch/archive` — `POST`
- `/crm/v4/associations/{fromObjectType}/{toObjectType}/labels` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-associations-api/4.0.0/crm/v4/associations/{fromObjectType}/{toObjectType}/labels) `POST`
- `/crm/v4/associations/{fromObjectType}/{toObjectType}/labels/{associationTypeId}` — `PUT` `DELETE`
- `/crm/v4/associations/definitions` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-associations-api/4.0.0/crm/v4/associations/definitions)

</details>

<details><summary><strong>hubspot-crm-feature-flags-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-crm-feature-flags-api/3.0.0"><code>hubspot-crm-feature-flags-api/3.0.0</code></a> · 5 paths · <code>hubspot-crm-feature-flags-api-openapi.yml</code></summary>

- `/feature-flags/v3/{appId}/flags/{flagName}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-feature-flags-api/3.0.0/feature-flags/v3/{appId}/flags/{flagName}) `PUT` `DELETE`
- `/feature-flags/v3/{appId}/flags/{flagName}/portals` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-feature-flags-api/3.0.0/feature-flags/v3/{appId}/flags/{flagName}/portals)
- `/feature-flags/v3/{appId}/flags/{flagName}/portals/{portalId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-feature-flags-api/3.0.0/feature-flags/v3/{appId}/flags/{flagName}/portals/{portalId}) `PUT` `DELETE`
- `/feature-flags/v3/{appId}/flags/{flagName}/portals/batch/upsert` — `POST`
- `/feature-flags/v3/{appId}/flags/{flagName}/portals/batch/delete` — `POST`

</details>

<details><summary><strong>hubspot-custom-workflow-actions-api</strong> · v4.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0"><code>hubspot-custom-workflow-actions-api/4.0.0</code></a> · 9 paths · <code>hubspot-custom-workflow-actions-api-openapi.yml</code></summary>

- `/automation/v4/actions/callbacks/{callbackId}/complete` — `POST`
- `/automation/v4/actions/callbacks/complete` — `POST`
- `/automation/v4/actions/{appId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}) `POST`
- `/automation/v4/actions/{appId}/{definitionId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}) `PATCH` `DELETE`
- `/automation/v4/actions/{appId}/{definitionId}/functions` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}/functions)
- `/automation/v4/actions/{appId}/{definitionId}/functions/{functionType}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}/functions/{functionType}) `PUT` `DELETE`
- `/automation/v4/actions/{appId}/{definitionId}/functions/{functionType}/{functionId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}/functions/{functionType}/{functionId}) `DELETE`
- `/automation/v4/actions/{appId}/{definitionId}/revisions` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}/revisions)
- `/automation/v4/actions/{appId}/{definitionId}/revisions/{revisionId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-custom-workflow-actions-api/4.0.0/automation/v4/actions/{appId}/{definitionId}/revisions/{revisionId})

</details>

<details><summary><strong>hubspot-cms-domains-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-cms-domains-api/3.0.0"><code>hubspot-cms-domains-api/3.0.0</code></a> · 2 paths · <code>hubspot-domains-api-openapi.yml</code></summary>

- `/cms/v3/domains/` — [`GET`](https://mocks.naftiko.net/rest/hubspot-cms-domains-api/3.0.0/cms/v3/domains/)
- `/cms/v3/domains/{domainId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-cms-domains-api/3.0.0/cms/v3/domains/{domainId})

</details>

<details><summary><strong>hubspot-crm-engagement-calls-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-crm-engagement-calls-api/3.0.0"><code>hubspot-crm-engagement-calls-api/3.0.0</code></a> · 8 paths · <code>hubspot-engagement-calls-api-openapi.yml</code></summary>

- `/crm/v3/objects/calls` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-engagement-calls-api/3.0.0/crm/v3/objects/calls) `POST`
- `/crm/v3/objects/calls/{callId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-engagement-calls-api/3.0.0/crm/v3/objects/calls/{callId}) `PATCH` `DELETE`
- `/crm/v3/objects/calls/batch/create` — `POST`
- `/crm/v3/objects/calls/batch/read` — `POST`
- `/crm/v3/objects/calls/batch/update` — `POST`
- `/crm/v3/objects/calls/batch/archive` — `POST`
- `/crm/v3/objects/calls/search` — `POST`
- `/crm/v3/objects/calls/gdpr-delete` — `POST`

</details>

<details><summary><strong>hubspot-crm-engagement-notes-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-crm-engagement-notes-api/3.0.0"><code>hubspot-crm-engagement-notes-api/3.0.0</code></a> · 8 paths · <code>hubspot-engagement-notes-openapi.yml</code></summary>

- `/crm/v3/objects/notes` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-engagement-notes-api/3.0.0/crm/v3/objects/notes) `POST`
- `/crm/v3/objects/notes/{noteId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-crm-engagement-notes-api/3.0.0/crm/v3/objects/notes/{noteId}) `PATCH` `DELETE`
- `/crm/v3/objects/notes/batch/create` — `POST`
- `/crm/v3/objects/notes/batch/read` — `POST`
- `/crm/v3/objects/notes/batch/update` — `POST`
- `/crm/v3/objects/notes/batch/archive` — `POST`
- `/crm/v3/objects/notes/search` — `POST`
- `/crm/v3/objects/notes/gdpr-delete` — `POST`

</details>

<details><summary><strong>hubspot-marketing-transactional-email-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-marketing-transactional-email-api/3.0.0"><code>hubspot-marketing-transactional-email-api/3.0.0</code></a> · 4 paths · <code>hubspot-marketing-emal-api-openapi.yml</code></summary>

- `/marketing/v3/transactional/smtp-tokens` — [`GET`](https://mocks.naftiko.net/rest/hubspot-marketing-transactional-email-api/3.0.0/marketing/v3/transactional/smtp-tokens) `POST`
- `/marketing/v3/transactional/smtp-tokens/{tokenId}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-marketing-transactional-email-api/3.0.0/marketing/v3/transactional/smtp-tokens/{tokenId}) `DELETE`
- `/marketing/v3/transactional/smtp-tokens/{tokenId}/password-reset` — `POST`
- `/marketing/v3/transactional/single-email/send` — `POST`

</details>

<details><summary><strong>hubspot-oauth-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-oauth-api/1.0.0"><code>hubspot-oauth-api/1.0.0</code></a> · 3 paths · <code>hubspot-oauth-api-openapi.yml</code></summary>

- `/oauth/v1/access-tokens/{token}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-oauth-api/1.0.0/oauth/v1/access-tokens/{token})
- `/oauth/v1/refresh-tokens/{token}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-oauth-api/1.0.0/oauth/v1/refresh-tokens/{token}) `DELETE`
- `/oauth/v1/token` — `POST`

</details>

<details><summary><strong>hubspot-cms-source-code-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/hubspot-cms-source-code-api/3.0.0"><code>hubspot-cms-source-code-api/3.0.0</code></a> · 5 paths · <code>hubspot-source-code-api-openapi.yml</code></summary>

- `/cms/v3/source-code/{environment}/content/{path}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-cms-source-code-api/3.0.0/cms/v3/source-code/{environment}/content/{path}) `POST` `PUT` `DELETE`
- `/cms/v3/source-code/{environment}/metadata/{path}` — [`GET`](https://mocks.naftiko.net/rest/hubspot-cms-source-code-api/3.0.0/cms/v3/source-code/{environment}/metadata/{path})
- `/cms/v3/source-code/{environment}/validate/{path}` — `POST`
- `/cms/v3/source-code/extract/async` — `POST`
- `/cms/v3/source-code/extract/async/tasks/{taskId}/status` — [`GET`](https://mocks.naftiko.net/rest/hubspot-cms-source-code-api/3.0.0/cms/v3/source-code/extract/async/tasks/{taskId}/status)

</details>

<details><summary><strong>openai-images-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/openai-images-api/1.0.0"><code>openai-images-api/1.0.0</code></a> · 3 paths · <code>images-openapi-original.yml</code></summary>

- `/images/generations` — `POST`
- `/images/edits` — `POST`
- `/images/variations` — `POST`

</details>

<details><summary><strong>linkedin-compliance-events-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-compliance-events-api/1.0.0"><code>linkedin-compliance-events-api/1.0.0</code></a> · 3 paths · <code>linkedin-compliance-events.yml</code></summary>

- `/v2/memberComplianceAuthorizations` — [`GET`](https://mocks.naftiko.net/rest/linkedin-compliance-events-api/1.0.0/v2/memberComplianceAuthorizations) `POST`
- `/v2/memberComplianceAuthorizations/developerApplication=urn:li:developerApplication:{DeveloperApplicationId}&member=urn:li:person:{PersonId}` — `DELETE`
- `/v2/complianceEvents` — [`GET`](https://mocks.naftiko.net/rest/linkedin-compliance-events-api/1.0.0/v2/complianceEvents)

</details>

<details><summary><strong>linkedin-learning-activity-reports-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-learning-activity-reports-api/1.0.0"><code>linkedin-learning-activity-reports-api/1.0.0</code></a> · 1 paths · <code>linkedin-learning-activity-reports.yml</code></summary>

- `/v2/learningActivityReports` — [`GET`](https://mocks.naftiko.net/rest/linkedin-learning-activity-reports-api/1.0.0/v2/learningActivityReports)

</details>

<details><summary><strong>linkedin-marketing-audience-insights-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-marketing-audience-insights-api/1.0.0"><code>linkedin-marketing-audience-insights-api/1.0.0</code></a> · 3 paths · <code>linkedin-marketing-audience-insights.yml</code></summary>

- `/adTargetingFacets` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-audience-insights-api/1.0.0/adTargetingFacets)
- `/adTargetingEntities` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-audience-insights-api/1.0.0/adTargetingEntities)
- `/targetingAudienceInsights` — `POST`

</details>

<details><summary><strong>linkedin-marketing-audiences-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-marketing-audiences-api/1.0.0"><code>linkedin-marketing-audiences-api/1.0.0</code></a> · 5 paths · <code>linkedin-marketing-audience.yml</code></summary>

- `/adAccounts` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-audiences-api/1.0.0/adAccounts)
- `/dmpSegments` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-audiences-api/1.0.0/dmpSegments) `POST`
- `/dmpSegments/{CompanySegmentId}/companies` — `POST`
- `/dmpSegments/{UserSegmentId}/users` — `POST`
- `/dmpSegments/{ListUploadSegmentId}/listUploads` — `POST`

</details>

<details><summary><strong>linkedin-marketing-campaign-management-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0"><code>linkedin-marketing-campaign-management-api/1.0.0</code></a> · 11 paths · <code>linkedin-marketing-campaigns.yml</code></summary>

- `/adAccountUsers/(account:urn:li:sponsoredAccount:{SponsoredAccountId},user:urn:li:person:{PersonId})` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccountUsers/(account:urn:li:sponsoredAccount:{SponsoredAccountId},user:urn:li:person:{PersonId})) `POST` `PUT` `DELETE`
- `/adAccountUsers` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccountUsers)
- `/organizationAcls` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/organizationAcls)
- `/adAccounts` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts) `POST`
- `/adAccounts/{SponsoredAccountId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts/{SponsoredAccountId}) `POST`
- `/adAccounts/{AdAccountsId}/adCampaignGroups` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts/{AdAccountsId}/adCampaignGroups) `DELETE`
- `/adAccounts/{AdAccountsId}/adCampaignGroups/{CampaignGroupId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts/{AdAccountsId}/adCampaignGroups/{CampaignGroupId}) `POST` `DELETE`
- `/adAccounts/{AdAccountsId}/adCampaigns` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts/{AdAccountsId}/adCampaigns)
- `/adAccounts/{AdAccountsId}/adCampaigns/{CampaignId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/adAccounts/{AdAccountsId}/adCampaigns/{CampaignId}) `POST`
- `/creatives` — `POST`
- `/audienceCounts` — [`GET`](https://mocks.naftiko.net/rest/linkedin-marketing-campaign-management-api/1.0.0/audienceCounts)

</details>

<details><summary><strong>community-management</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/community-management/1.0.0"><code>community-management/1.0.0</code></a> · 17 paths · <code>linkedin-marketing-community.yml</code></summary>

- `/shares` — `POST`
- `/eventSubscriptions/(developerApplication:urn:li:developerApplication:{application_id},user:urn:li:person:{person_id},entity:urn:li:organization:{organization_id},eventType:ORGANIZATION_SOCIAL_ACTION_NOTIFICATIONS)` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/eventSubscriptions/(developerApplication:urn:li:developerApplication:{application_id},user:urn:li:person:{person_id},entity:urn:li:organization:{organization_id},eventType:ORGANIZATION_SOCIAL_ACTION_NOTIFICATIONS)) `PUT`
- `/eventSubscriptions` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/eventSubscriptions)
- `/eventSubscriptions/(developerApplication:{application_id},user:{person_id},entity:{organization_id},eventType:ORGANIZATION_SOCIAL_ACTION_NOTIFICATIONS)` — `DELETE`
- `/organizationalEntityFollowerStatistics` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationalEntityFollowerStatistics)
- `/organizationPageStatistics` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationPageStatistics)
- `/organizationalEntityShareStatistics` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationalEntityShareStatistics)
- `/peopleTypeahead` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/peopleTypeahead)
- `/vanityUrl` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/vanityUrl)
- `/organizations` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizations)
- `/organizations/{organization_id}` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizations/{organization_id})
- `/organizationsLookup` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationsLookup)
- `/networkSizes/urn:li:organization:{organization_id}` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/networkSizes/urn:li:organization:{organization_id})
- `/organizationBrands` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationBrands)
- `/organizationBrands/{organizationBrand_id}` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationBrands/{organizationBrand_id})
- `/organizationBrandsLookup` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationBrandsLookup)
- `/organizationAcls` — [`GET`](https://mocks.naftiko.net/rest/community-management/1.0.0/organizationAcls)

</details>

<details><summary><strong>content-apis</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/content-apis/1.0.0"><code>content-apis/1.0.0</code></a> · 25 paths · <code>linkedin-marketing-content.yml</code></summary>

- `/rest/inMailContents/` — `POST`
- `/rest/inMailContents/{adInMailContentId}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/inMailContents/{adInMailContentId}) `POST`
- `/rest/inMailContents` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/inMailContents) `POST`
- `/` — `PUT`
- `/images` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/images) `POST`
- `/rest/images/{image_urn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/images/{image_urn})
- `/rest/images` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/images)
- `/rest/posts` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/posts)
- `/rest/posts/{postId}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/rest/posts/{postId})
- `/videos` — `POST`
- `/images/{image_urn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/images/{image_urn})
- `/creatives` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/creatives) `POST`
- `/creatives/{urn_creatives}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/creatives/{urn_creatives})
- `/creatives/{creative ID}` — `POST` `DELETE`
- `/posts` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/posts) `POST`
- `/posts/{encoded ugcPostUrn|shareUrn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/posts/{encoded ugcPostUrn|shareUrn}) `DELETE`
- `/posts/{shared ID}/{ugcPosts ID}` — `POST`
- `/conversationAds` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/conversationAds) `POST`
- `/conversationAds/{conversationUrn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/conversationAds/{conversationUrn}) `POST`
- `/conversationAds/{conversationAdsId}/sponsoredMessageContents` — `POST`
- `/conversationAds/{conversationUrn}/sponsoredMessageContents/{messageUrn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/conversationAds/{conversationUrn}/sponsoredMessageContents/{messageUrn}) `POST`
- `/conversationAds/{conversationUrn}/sponsoredMessageContents` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/conversationAds/{conversationUrn}/sponsoredMessageContents) `POST` `DELETE`
- `/creatives/{sponsoredCreative-urn}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0/creatives/{sponsoredCreative-urn}) `POST` `DELETE`
- `/documents` — `POST`
- `//documents/{document_asset_id}` — [`GET`](https://mocks.naftiko.net/rest/content-apis/1.0.0//documents/{document_asset_id})

</details>

<details><summary><strong>conversions-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/conversions-api/1.0.0"><code>conversions-api/1.0.0</code></a> · 5 paths · <code>linkedin-marketing-conversions.yml</code></summary>

- `/adAccountUsers` — [`GET`](https://mocks.naftiko.net/rest/conversions-api/1.0.0/adAccountUsers)
- `/conversions` — [`GET`](https://mocks.naftiko.net/rest/conversions-api/1.0.0/conversions) `POST`
- `/adAccounts/{sponsoredaccount_id}/adCampaigns` — [`GET`](https://mocks.naftiko.net/rest/conversions-api/1.0.0/adAccounts/{sponsoredaccount_id}/adCampaigns)
- `/campaignConversions/(campaign:urn:li:sponsoredCampaign:{campaign_id},conversion:urn:lla:llaPartnerConversion:{conversion_id})` — `PUT`
- `/conversionEvents` — `POST`

</details>

<details><summary><strong>lead-sync</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/lead-sync/1.0.0"><code>lead-sync/1.0.0</code></a> · 7 paths · <code>linkedin-marketing-leads.yml</code></summary>

- `/organizationAcls` — [`GET`](https://mocks.naftiko.net/rest/lead-sync/1.0.0/organizationAcls)
- `/leadForms` — [`GET`](https://mocks.naftiko.net/rest/lead-sync/1.0.0/leadForms)
- `/leadFormResponses` — [`GET`](https://mocks.naftiko.net/rest/lead-sync/1.0.0/leadFormResponses)
- `/leadNotifications` — `POST`
- `/leadFormResponses/{lead_id}` — [`GET`](https://mocks.naftiko.net/rest/lead-sync/1.0.0/leadFormResponses/{lead_id})
- `/leadnotifications/<webhook id>` — `DELETE`
- `/adAccounts` — [`GET`](https://mocks.naftiko.net/rest/lead-sync/1.0.0/adAccounts)

</details>

<details><summary><strong>media-planning</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/media-planning/1.0.0"><code>media-planning/1.0.0</code></a> · 3 paths · <code>linkedin-marketing-media-planning.yml</code></summary>

- `/adTargetingFacets` — [`GET`](https://mocks.naftiko.net/rest/media-planning/1.0.0/adTargetingFacets)
- `/adTargetingEntities` — [`GET`](https://mocks.naftiko.net/rest/media-planning/1.0.0/adTargetingEntities)
- `/mediaPlanning` — `POST`

</details>

<details><summary><strong>reporting-roi</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/reporting-roi/1.0.0"><code>reporting-roi/1.0.0</code></a> · 1 paths · <code>linkedin-marketing-reporting-roi.yml</code></summary>

- `/adAnalytics` — [`GET`](https://mocks.naftiko.net/rest/reporting-roi/1.0.0/adAnalytics)

</details>

<details><summary><strong>linkedin-pages-data-portability-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0"><code>linkedin-pages-data-portability-api/1.0.0</code></a> · 10 paths · <code>linkedin-regulations-data-portability.yml</code></summary>

- `/rest/dmaOrganizations` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaOrganizations)
- `/rest/dmaOrganizations/{organizationId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaOrganizations/{organizationId})
- `/rest/dmaOrganizationAcls` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaOrganizationAcls)
- `/rest/dmaOrganizationalPageContentAnalytics` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaOrganizationalPageContentAnalytics)
- `/rest/dmaPosts` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaPosts)
- `/rest/dmaReactions` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaReactions)
- `/rest/dmaComments` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaComments)
- `/rest/dmaLeadGenResponses` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaLeadGenResponses)
- `/rest/dmaEvents` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaEvents)
- `/rest/dmaBusinessManagerAccountRelationships` — [`GET`](https://mocks.naftiko.net/rest/linkedin-pages-data-portability-api/1.0.0/rest/dmaBusinessManagerAccountRelationships)

</details>

<details><summary><strong>linkedin-ads-transparency-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-ads-transparency-api/1.0.0"><code>linkedin-ads-transparency-api/1.0.0</code></a> · 1 paths · <code>linkedin-regulatory-ads-transparency.yml</code></summary>

- `/rest/advertiserTransparencyData/urn:li:sponsoredAccount:{sponsoredaccount_id}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-ads-transparency-api/1.0.0/rest/advertiserTransparencyData/urn:li:sponsoredAccount:{sponsoredaccount_id})

</details>

<details><summary><strong>linkedin-sales-navigator-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0"><code>linkedin-sales-navigator-api/1.0.0</code></a> · 8 paths · <code>linkedin-sales-navigator.yml</code></summary>

- `/salesContracts` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/salesContracts)
- `/salesAnalyticsExportJobs/{JobId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/salesAnalyticsExportJobs/{JobId})
- `/salesAnalyticsExportJobs` — `POST`
- `/salesAccessTokens` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/salesAccessTokens)
- `/salesNavigatorProfileAssociations/{InstanceId},{Partner},{RecordId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/salesNavigatorProfileAssociations/{InstanceId},{Partner},{RecordId})
- `/salesNavigatorProfileAssociations` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/salesNavigatorProfileAssociations)
- `/crmDataValidationExportJobs` — `POST`
- `/crmDataValidationExportJobs/{JobId}` — [`GET`](https://mocks.naftiko.net/rest/linkedin-sales-navigator-api/1.0.0/crmDataValidationExportJobs/{JobId})

</details>

<details><summary><strong>linkedin-job-posting-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-job-posting-api/1.0.0"><code>linkedin-job-posting-api/1.0.0</code></a> · 3 paths · <code>linkedin-talent-job-posting.yml</code></summary>

- `/v2/simpleJobPostings` — `POST`
- `/v2/simpleJobPostingTasks` — [`GET`](https://mocks.naftiko.net/rest/linkedin-job-posting-api/1.0.0/v2/simpleJobPostingTasks)
- `/v2/atsIntegrations` — [`GET`](https://mocks.naftiko.net/rest/linkedin-job-posting-api/1.0.0/v2/atsIntegrations) `POST`

</details>

<details><summary><strong>linkedin-parent-application-management-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-parent-application-management-api/1.0.0"><code>linkedin-parent-application-management-api/1.0.0</code></a> · 2 paths · <code>linkedin-talent-learning-parent-application.yml</code></summary>

- `/v2/provisionedApplications` — [`GET`](https://mocks.naftiko.net/rest/linkedin-parent-application-management-api/1.0.0/v2/provisionedApplications) `POST`
- `/v2/provisionedApplications/{customer_application_urn}` — `POST`

</details>

<details><summary><strong>linkedin-recruiter-system-connect-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0"><code>linkedin-recruiter-system-connect-api/1.0.0</code></a> · 8 paths · <code>linkedin-talent-recruiter-system-connect.yml</code></summary>

- `/oauth/v2/accessToken` — `POST`
- `/v2/atsIntegrations` — [`GET`](https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0/v2/atsIntegrations) `POST`
- `/v2/atsCandidates` — [`GET`](https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0/v2/atsCandidates) `PUT` `DELETE`
- `/v2/atsApplications` — `PUT` `DELETE`
- `/v2/hireMediaUrl` — `POST`
- `/v2/exportedCandidates` — [`GET`](https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0/v2/exportedCandidates)
- `/v2/seats` — [`GET`](https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0/v2/seats)
- `/v2/atsEntityAcls` — [`GET`](https://mocks.naftiko.net/rest/linkedin-recruiter-system-connect-api/1.0.0/v2/atsEntityAcls) `PUT` `DELETE`

</details>

<details><summary><strong>microsoft-365-copilot-apis</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0"><code>microsoft-365-copilot-apis/1.0.0</code></a> · 15 paths · <code>microsoft-copilot-api.yaml</code></summary>

- `/copilot/retrieval/query` — `POST`
- `/copilot/search/query` — `POST`
- `/copilot/interactions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/interactions)
- `/copilot/interactions/{interactionId}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/interactions/{interactionId})
- `/copilot/subscriptions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/subscriptions) `POST`
- `/copilot/subscriptions/{subscriptionId}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/subscriptions/{subscriptionId}) `PATCH` `DELETE`
- `/copilot/meetings/{meetingId}/insights` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/meetings/{meetingId}/insights)
- `/copilot/meetings` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/meetings)
- `/copilot/chat/completions` — `POST`
- `/copilot/chat/threads` — `POST`
- `/copilot/chat/threads/{threadId}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/chat/threads/{threadId})
- `/reports/copilot/usage` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/reports/copilot/usage)
- `/reports/copilot/usage/userDetail` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/reports/copilot/usage/userDetail)
- `/copilot/packages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/packages)
- `/copilot/packages/{packageId}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-365-copilot-apis/1.0.0/copilot/packages/{packageId}) `PATCH` `DELETE`

</details>

<details><summary><strong>microsoft-excel-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0"><code>microsoft-excel-api/1.0.0</code></a> · 13 paths · <code>microsoft-excel-openapi.yaml</code></summary>

- `/me/drive/items/{parent-id}:/{filename}:/content` — `PUT`
- `/me/drive/items/{parent-id}:/{filename}:/createUploadSession` — `POST`
- `/me/drive/items/{parent-id}/children` — `POST`
- `/me/drive/items/{item-id}/content` — [`GET`](https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0/me/drive/items/{item-id}/content)
- `/me/drive/items/{item-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0/me/drive/items/{item-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/permissions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0/me/drive/items/{item-id}/permissions)
- `/me/drive/items/{item-id}/permissions/{permission-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0/me/drive/items/{item-id}/permissions/{permission-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/invite` — `POST`
- `/me/drive/items/{item-id}/createLink` — `POST`
- `/me/drive/items/{item-id}/checkout` — `POST`
- `/me/drive/items/{item-id}/checkin` — `POST`
- `/me/drive/root/search(q='{search-text}')` — [`GET`](https://mocks.naftiko.net/rest/microsoft-excel-api/1.0.0/me/drive/root/search(q='{search-text}'))
- `/search/query` — `POST`

</details>

<details><summary><strong>microsoft-outlook-calendar-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0"><code>microsoft-outlook-calendar-api/1.0.0</code></a> · 13 paths · <code>microsoft-outlook-calendar-api.yaml</code></summary>

- `/me/calendars` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendars) `POST`
- `/me/calendarGroups/{calendarGroupId}/calendars` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendarGroups/{calendarGroupId}/calendars) `POST`
- `/me/calendars/{calendarId}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendars/{calendarId}) `PATCH` `DELETE`
- `/me/calendars/{calendarId}/permanentDelete` — `POST`
- `/groups/{groupId}/calendar` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/groups/{groupId}/calendar) `PATCH`
- `/me/calendarView` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendarView)
- `/me/calendars/{calendarId}/calendarView` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendars/{calendarId}/calendarView)
- `/me/calendars/{calendarId}/events` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-calendar-api/1.0.0/me/calendars/{calendarId}/events) `POST`
- `/me/events` — `POST`
- `/me/calendar/getSchedule` — `POST`
- `/me/findMeetingTimes` — `POST`
- `/me/calendars/{calendarId}/singleValueExtendedProperties` — `POST`
- `/me/calendars/{calendarId}/multiValueExtendedProperties` — `POST`

</details>

<details><summary><strong>microsoft-outlook-mail-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0"><code>microsoft-outlook-mail-api/1.0.0</code></a> · 38 paths · <code>microsoft-outlook-mail-api.yaml</code></summary>

- `/me/messages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages) `POST`
- `/me/messages/{message-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}) `PATCH` `DELETE`
- `/me/messages/{message-id}/$value` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/$value)
- `/me/messages/{message-id}/reply` — `POST`
- `/me/messages/{message-id}/replyAll` — `POST`
- `/me/messages/{message-id}/forward` — `POST`
- `/me/sendMail` — `POST`
- `/me/messages/{message-id}/send` — `POST`
- `/me/messages/{message-id}/attachments` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/attachments) `POST`
- `/me/messages/{message-id}/attachments/{attachment-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/attachments/{attachment-id}) `DELETE`
- `/me/messages/{message-id}/attachments/{attachment-id}/$value` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/attachments/{attachment-id}/$value)
- `/me/mailFolders` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders) `POST`
- `/me/mailFolders/{mailFolder-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/{mailFolder-id}) `PATCH` `DELETE`
- `/me/mailFolders/{mailFolder-id}/messages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/{mailFolder-id}/messages)
- `/me/mailFolders/{mailFolder-id}/childFolders` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/{mailFolder-id}/childFolders) `POST`
- `/me/mailFolders/{mailFolder-id}/copy` — `POST`
- `/me/mailFolders/{mailFolder-id}/move` — `POST`
- `/me/mailFolders/{mailFolder-id}/childFolders/mailSearchFolder` — `POST`
- `/me/mailFolders/{mailFolder-id}/childFolders/{childFolder-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/{mailFolder-id}/childFolders/{childFolder-id}) `PATCH` `DELETE`
- `/me/outlook/masterCategories` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/outlook/masterCategories) `POST`
- `/me/outlook/masterCategories/{category-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/outlook/masterCategories/{category-id}) `PATCH` `DELETE`
- `/me/mailFolders/inbox/messageRules` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/inbox/messageRules) `POST`
- `/me/mailFolders/inbox/messageRules/{messageRule-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/inbox/messageRules/{messageRule-id}) `PATCH` `DELETE`
- `/me/inferenceClassification/overrides` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/inferenceClassification/overrides) `POST`
- `/me/inferenceClassification/overrides/{override-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/inferenceClassification/overrides/{override-id}) `PATCH` `DELETE`
- `/me/mailboxSettings` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailboxSettings) `PATCH`
- `/me/outlook/supportedLanguages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/outlook/supportedLanguages)
- `/me/outlook/supportedTimeZones` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/outlook/supportedTimeZones)
- `/me/getMailTips` — `POST`
- `/subscriptions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/subscriptions) `POST`
- `/subscriptions/{subscription-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/subscriptions/{subscription-id}) `PATCH` `DELETE`
- `/me/mailFolders/delta` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/delta)
- `/me/mailFolders/{mailFolder-id}/messages/delta` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/mailFolders/{mailFolder-id}/messages/delta)
- `/me/messages/{message-id}/messageTrace` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/messageTrace)
- `/me/messages/{message-id}/extensions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/extensions) `POST`
- `/me/messages/{message-id}/extensions/{extension-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/extensions/{extension-id}) `PATCH` `DELETE`
- `/me/messages/{message-id}/singleValueExtendedProperties` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/singleValueExtendedProperties) `POST`
- `/me/messages/{message-id}/multiValueExtendedProperties` — [`GET`](https://mocks.naftiko.net/rest/microsoft-outlook-mail-api/1.0.0/me/messages/{message-id}/multiValueExtendedProperties) `POST`

</details>

<details><summary><strong>microsoft-powerpoint-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0"><code>microsoft-powerpoint-api/1.0.0</code></a> · 13 paths · <code>microsoft-powerpoint-api.yaml</code></summary>

- `/me/drive/items/{parent-id}:/{filename}:/content` — `PUT`
- `/me/drive/items/{parent-id}:/{filename}:/createUploadSession` — `POST`
- `/me/drive/items/{parent-id}/children` — `POST`
- `/me/drive/items/{item-id}/content` — [`GET`](https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0/me/drive/items/{item-id}/content)
- `/me/drive/items/{item-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0/me/drive/items/{item-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/permissions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0/me/drive/items/{item-id}/permissions)
- `/me/drive/items/{item-id}/permissions/{permission-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0/me/drive/items/{item-id}/permissions/{permission-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/invite` — `POST`
- `/me/drive/items/{item-id}/createLink` — `POST`
- `/me/drive/items/{item-id}/checkout` — `POST`
- `/me/drive/items/{item-id}/checkin` — `POST`
- `/me/drive/root/search(q='{search-text}')` — [`GET`](https://mocks.naftiko.net/rest/microsoft-powerpoint-api/1.0.0/me/drive/root/search(q='{search-text}'))
- `/search/query` — `POST`

</details>

<details><summary><strong>microsoft-teams-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0"><code>microsoft-teams-api/1.0.0</code></a> · 52 paths · <code>microsoft-teams-openapi.yaml</code></summary>

- `/teams` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams) `POST`
- `/teams/{team-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}) `PATCH` `DELETE`
- `/groups` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/groups) `POST`
- `/groups/{group-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/groups/{group-id}) `PATCH` `DELETE`
- `/teams/{team-id}/channels` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels) `POST`
- `/teams/{team-id}/channels/{channel-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels/{channel-id}) `PATCH` `DELETE`
- `/teams/{team-id}/channels/{channel-id}/tabs` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels/{channel-id}/tabs) `POST`
- `/teams/{team-id}/channels/{channel-id}/tabs/{tab-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels/{channel-id}/tabs/{tab-id}) `PATCH` `DELETE`
- `/appCatalogs/teamsApps` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/appCatalogs/teamsApps) `POST`
- `/appCatalogs/teamsApps/{app-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/appCatalogs/teamsApps/{app-id}) `DELETE`
- `/teams/{team-id}/installedApps` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/installedApps) `POST`
- `/teams/{team-id}/installedApps/{installation-id}` — `DELETE`
- `/chats` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/chats) `POST`
- `/chats/{chat-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/chats/{chat-id}) `PATCH`
- `/chats/{chat-id}/messages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/chats/{chat-id}/messages) `POST`
- `/teams/{team-id}/channels/{channel-id}/messages` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels/{channel-id}/messages) `POST`
- `/teams/{team-id}/channels/{channel-id}/messages/{message-id}/replies` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/channels/{channel-id}/messages/{message-id}/replies) `POST`
- `/teams/{team-id}/tags` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/tags) `POST`
- `/teams/{team-id}/tags/{tag-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/tags/{tag-id}) `PATCH` `DELETE`
- `/teams/{team-id}/tags/{tag-id}/members` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/tags/{tag-id}/members) `POST`
- `/communications/calls` — `POST`
- `/communications/calls/{call-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/communications/calls/{call-id}) `DELETE`
- `/communications/calls/{call-id}/answer` — `POST`
- `/communications/calls/{call-id}/participants/invite` — `POST`
- `/communications/calls/{call-id}/playPrompt` — `POST`
- `/communications/calls/{call-id}/recordResponse` — `POST`
- `/communications/calls/{call-id}/transfer` — `POST`
- `/communications/callRecords` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/communications/callRecords)
- `/communications/callRecords/{callRecord-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/communications/callRecords/{callRecord-id})
- `/communications/callRecords/{callRecord-id}/sessions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/communications/callRecords/{callRecord-id}/sessions)
- `/me/onlineMeetings` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/me/onlineMeetings) `POST`
- `/me/onlineMeetings/{meeting-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/me/onlineMeetings/{meeting-id}) `PATCH` `DELETE`
- `/me/onlineMeetings/{meeting-id}/meetingAttendanceReport` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/me/onlineMeetings/{meeting-id}/meetingAttendanceReport)
- `/me/presence` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/me/presence)
- `/users/{user-id}/presence` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/users/{user-id}/presence)
- `/communications/getPresencesByUserId` — `POST`
- `/teamwork/workforceIntegrations` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teamwork/workforceIntegrations) `POST`
- `/teamwork/workforceIntegrations/{workforceIntegration-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teamwork/workforceIntegrations/{workforceIntegration-id}) `PATCH` `DELETE`
- `/teams/{team-id}/schedule` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule) `PUT`
- `/teams/{team-id}/schedule/shifts` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/shifts) `POST`
- `/teams/{team-id}/schedule/shifts/{shift-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/shifts/{shift-id}) `PUT` `DELETE`
- `/teams/{team-id}/schedule/timesOff` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/timesOff) `POST`
- `/teams/{team-id}/schedule/timesOff/{timeOff-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/timesOff/{timeOff-id}) `PUT` `DELETE`
- `/teams/{team-id}/schedule/timeOffReasons` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/timeOffReasons) `POST`
- `/teams/{team-id}/schedule/timeCards` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/timeCards)
- `/teams/{team-id}/schedule/timeCards/{timeCard-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/teams/{team-id}/schedule/timeCards/{timeCard-id})
- `/teams/{team-id}/schedule/timeCards/{timeCard-id}/clockIn` — `POST`
- `/teams/{team-id}/schedule/timeCards/{timeCard-id}/clockOut` — `POST`
- `/employeeExperience/learningProviders` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/employeeExperience/learningProviders) `POST`
- `/employeeExperience/learningProviders/{learningProvider-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/employeeExperience/learningProviders/{learningProvider-id}) `PATCH` `DELETE`
- `/employeeExperience/learningProviders/{learningProvider-id}/learningContents` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/employeeExperience/learningProviders/{learningProvider-id}/learningContents) `POST`
- `/employeeExperience/learningProviders/{learningProvider-id}/learningContents/{learningContent-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-teams-api/1.0.0/employeeExperience/learningProviders/{learningProvider-id}/learningContents/{learningContent-id}) `PATCH` `DELETE`

</details>

<details><summary><strong>microsoft-docs-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0"><code>microsoft-docs-api/1.0.0</code></a> · 13 paths · <code>microsoft-word-openapi.yaml</code></summary>

- `/me/drive/items/{parent-id}:/{filename}:/content` — `PUT`
- `/me/drive/items/{parent-id}:/{filename}:/createUploadSession` — `POST`
- `/me/drive/items/{parent-id}/children` — `POST`
- `/me/drive/items/{item-id}/content` — [`GET`](https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0/me/drive/items/{item-id}/content)
- `/me/drive/items/{item-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0/me/drive/items/{item-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/permissions` — [`GET`](https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0/me/drive/items/{item-id}/permissions)
- `/me/drive/items/{item-id}/permissions/{permission-id}` — [`GET`](https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0/me/drive/items/{item-id}/permissions/{permission-id}) `PATCH` `DELETE`
- `/me/drive/items/{item-id}/invite` — `POST`
- `/me/drive/items/{item-id}/createLink` — `POST`
- `/me/drive/items/{item-id}/checkout` — `POST`
- `/me/drive/items/{item-id}/checkin` — `POST`
- `/me/drive/root/search(q='{search-text}')` — [`GET`](https://mocks.naftiko.net/rest/microsoft-docs-api/1.0.0/me/drive/root/search(q='{search-text}'))
- `/search/query` — `POST`

</details>

<details><summary><strong>openai-models-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/openai-models-api/1.0.0"><code>openai-models-api/1.0.0</code></a> · 2 paths · <code>models-openapi-original.yml</code></summary>

- `/models` — [`GET`](https://mocks.naftiko.net/rest/openai-models-api/1.0.0/models)
- `/models/{model}` — [`GET`](https://mocks.naftiko.net/rest/openai-models-api/1.0.0/models/{model}) `DELETE`

</details>

<details><summary><strong>naftiko-shipyard-legacy-dockyard-api</strong> · v1.0.0-alpha1 · <a href="https://mocks.naftiko.net/rest/naftiko-shipyard-legacy-dockyard-api/1.0.0-alpha1"><code>naftiko-shipyard-legacy-dockyard-api/1.0.0-alpha1</code></a> · 1 paths · <code>naftiko-shipyard-legacy-dockyard-api.yml</code></summary>

- `/vessels` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-legacy-dockyard-api/1.0.0-alpha1/vessels)

</details>

<details><summary><strong>naftiko-shipyard-maritime-registry-api</strong> · v1.0.0-alpha1 · <a href="https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1"><code>naftiko-shipyard-maritime-registry-api/1.0.0-alpha1</code></a> · 6 paths · <code>naftiko-shipyard-maritime-registry-api.yml</code></summary>

- `/ships` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1/ships)
- `/ships/{imo_number}` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1/ships/{imo_number})
- `/voyages` — `POST`
- `/voyages/{voyageId}` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1/voyages/{voyageId})
- `/crew` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1/crew)
- `/cargo` — [`GET`](https://mocks.naftiko.net/rest/naftiko-shipyard-maritime-registry-api/1.0.0-alpha1/cargo)

</details>

<details><summary><strong>nist-cybersecurity-framework-csf-2-0-sandbox-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0"><code>nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0</code></a> · 11 paths · <code>nist-csf-2.0-sandbox-openapi.yaml</code></summary>

- `/csf/functions` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/csf/functions)
- `/csf/functions/{functionId}/categories` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/csf/functions/{functionId}/categories)
- `/csf/categories/{categoryId}/subcategories` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/csf/categories/{categoryId}/subcategories)
- `/organizations` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations) `POST`
- `/organizations/{orgId}` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId})
- `/organizations/{orgId}/profiles` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId}/profiles) `POST`
- `/organizations/{orgId}/profiles/{profileId}` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId}/profiles/{profileId}) `PUT`
- `/organizations/{orgId}/assessments` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId}/assessments) `POST`
- `/organizations/{orgId}/assessments/{assessmentId}` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId}/assessments/{assessmentId}) `PATCH`
- `/organizations/{orgId}/gap-analysis` — `POST`
- `/organizations/{orgId}/gap-analysis/{gapId}` — [`GET`](https://mocks.naftiko.net/rest/nist-cybersecurity-framework-csf-2-0-sandbox-api/1.0.0/organizations/{orgId}/gap-analysis/{gapId})

</details>

<details><summary><strong>nist-sp-800-53-rev-5-sandbox-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0"><code>nist-sp-800-53-rev-5-sandbox-api/1.0.0</code></a> · 14 paths · <code>nist-sp-800-53-openapi.yaml</code></summary>

- `/catalog/families` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/catalog/families)
- `/catalog/families/{familyId}/controls` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/catalog/families/{familyId}/controls)
- `/catalog/controls/{controlId}` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/catalog/controls/{controlId})
- `/baselines` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/baselines)
- `/baselines/{baselineId}/controls` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/baselines/{baselineId}/controls)
- `/systems` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems) `POST`
- `/systems/{systemId}` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId})
- `/systems/{systemId}/ssp` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/ssp) `POST`
- `/systems/{systemId}/ssp/{sspId}` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/ssp/{sspId}) `PUT`
- `/systems/{systemId}/ssp/{sspId}/implementations` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/ssp/{sspId}/implementations) `POST`
- `/systems/{systemId}/assessments` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/assessments) `POST`
- `/systems/{systemId}/assessments/{assessmentId}` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/assessments/{assessmentId}) `PATCH`
- `/systems/{systemId}/poam` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/poam) `POST`
- `/systems/{systemId}/poam/{poamId}` — [`GET`](https://mocks.naftiko.net/rest/nist-sp-800-53-rev-5-sandbox-api/1.0.0/systems/{systemId}/poam/{poamId}) `PATCH`

</details>

<details><summary><strong>notion-api</strong> · v1.1.0 · <a href="https://mocks.naftiko.net/rest/notion-api/1.1.0"><code>notion-api/1.1.0</code></a> · 26 paths · <code>notion-openapi.yml</code></summary>

- `/oauth/token` — `POST`
- `/oauth/token/introspect` — `POST`
- `/oauth/token/revoke` — `POST`
- `/oauth/token/refresh` — `POST`
- `/blocks/{block_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/blocks/{block_id}) `PATCH` `DELETE`
- `/blocks/{block_id}/children` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/blocks/{block_id}/children) `PATCH`
- `/comments` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/comments) `POST`
- `/comments/{comment_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/comments/{comment_id})
- `/databases` — `POST`
- `/databases/{database_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/databases/{database_id}) `PATCH`
- `/data_sources` — `POST`
- `/data_sources/{data_source_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/data_sources/{data_source_id}) `PATCH`
- `/data_sources/{data_source_id}/query` — `POST`
- `/data_sources/{data_source_id}/templates` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/data_sources/{data_source_id}/templates)
- `/file_uploads` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/file_uploads) `POST`
- `/file_uploads/{file_upload_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/file_uploads/{file_upload_id})
- `/file_uploads/{file_upload_id}/send` — `POST`
- `/file_uploads/{file_upload_id}/complete` — `POST`
- `/pages` — `POST`
- `/pages/{page_id}/properties/{property_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/pages/{page_id}/properties/{property_id})
- `/pages/{page_id}/move` — `POST`
- `/pages/{page_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/pages/{page_id}) `PATCH`
- `/search` — `POST`
- `/users` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/users)
- `/users/{user_id}` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/users/{user_id})
- `/users/me` — [`GET`](https://mocks.naftiko.net/rest/notion-api/1.1.0/users/me)

</details>

<details><summary><strong>webflow-pages-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-pages-api/1.0.0"><code>webflow-pages-api/1.0.0</code></a> · 4 paths · <code>pages-openapi-original.yml</code></summary>

- `/sites/{site_id}/pages` — [`GET`](https://mocks.naftiko.net/rest/webflow-pages-api/1.0.0/sites/{site_id}/pages)
- `/pages/{page_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-pages-api/1.0.0/pages/{page_id}) `PUT`
- `/pages/{page_id}/dom` — [`GET`](https://mocks.naftiko.net/rest/webflow-pages-api/1.0.0/pages/{page_id}/dom) `POST`
- `/pages/{page_id}/custom_code` — [`GET`](https://mocks.naftiko.net/rest/webflow-pages-api/1.0.0/pages/{page_id}/custom_code) `PUT` `DELETE`

</details>

<details><summary><strong>webflow-sites-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0"><code>webflow-sites-api/1.0.0</code></a> · 45 paths · <code>sites-openapi-original.yml</code></summary>

- `/workspaces/{workspace_id}/sites` — `POST`
- `/sites` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites)
- `/sites/{site_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}) `PATCH` `DELETE`
- `/sites/{site_id}/custom_domains` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/custom_domains)
- `/sites/{site_id}/publish` — `POST`
- `/sites/{site_id}/redirects` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/redirects) `POST`
- `/sites/{site_id}/redirects/{redirect_id}` — `PATCH` `DELETE`
- `/sites/{site_id}/plan` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/plan)
- `/sites/{site_id}/robots_txt` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/robots_txt) `PUT` `PATCH` `DELETE`
- `/sites/{site_id}/well_known` — `PUT` `DELETE`
- `/sites/{site_id}/activity_logs` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/activity_logs)
- `/sites/{site_id}/collections` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/collections) `POST`
- `/sites/{site_id}/comments` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/comments)
- `/sites/{site_id}/comments/{comment_thread_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/comments/{comment_thread_id})
- `/sites/{site_id}/comments/{comment_thread_id}/replies` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/comments/{comment_thread_id}/replies)
- `/sites/{site_id}/pages` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/pages)
- `/sites/{site_id}/components` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/components)
- `/sites/{site_id}/components/{component_id}/dom` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/components/{component_id}/dom) `POST`
- `/sites/{site_id}/components/{component_id}/properties` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/components/{component_id}/properties) `POST`
- `/sites/{site_id}/custom_code` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/custom_code) `PUT` `DELETE`
- `/sites/{site_id}/registered_scripts` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/registered_scripts)
- `/sites/{site_id}/registered_scripts/hosted` — `POST`
- `/sites/{site_id}/registered_scripts/inline` — `POST`
- `/sites/{site_id}/custom_code/blocks` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/custom_code/blocks)
- `/sites/{site_id}/assets` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/assets) `POST`
- `/sites/{site_id}/asset_folders` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/asset_folders) `POST`
- `/sites/{site_id}/webhooks` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/webhooks) `POST`
- `/sites/{site_id}/forms` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/forms)
- `/sites/{site_id}/form_submissions` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/form_submissions)
- `/sites/{site_id}/forms/{form_id}/submissions` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/forms/{form_id}/submissions)
- `/sites/{site_id}/form_submissions/{form_submission_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/form_submissions/{form_submission_id}) `PATCH` `DELETE`
- `/sites/{site_id}/users` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/users)
- `/sites/{site_id}/users/{user_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/users/{user_id}) `PATCH` `DELETE`
- `/sites/{site_id}/users/invite` — `POST`
- `/sites/{site_id}/accessgroups` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/accessgroups)
- `/sites/{site_id}/products` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/products) `POST`
- `/sites/{site_id}/products/{product_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/products/{product_id}) `PATCH`
- `/sites/{site_id}/products/{product_id}/skus` — `POST`
- `/sites/{site_id}/products/{product_id}/skus/{sku_id}` — `PATCH`
- `/sites/{site_id}/orders` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/orders)
- `/sites/{site_id}/orders/{order_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/orders/{order_id}) `PATCH`
- `/sites/{site_id}/orders/{order_id}/fulfill` — `POST`
- `/sites/{site_id}/orders/{order_id}/unfulfill` — `POST`
- `/sites/{site_id}/orders/{order_id}/refund` — `POST`
- `/sites/{site_id}/ecommerce/settings` — [`GET`](https://mocks.naftiko.net/rest/webflow-sites-api/1.0.0/sites/{site_id}/ecommerce/settings)

</details>

<details><summary><strong>slack-admin-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-admin-api/1.0.0"><code>slack-admin-api/1.0.0</code></a> · 56 paths · <code>slack-admin-openapi.yml</code></summary>

- `/admin.apps.approve` — `POST`
- `/admin.apps.approved.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.apps.approved.list)
- `/admin.apps.requests.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.apps.requests.list)
- `/admin.apps.restrict` — `POST`
- `/admin.apps.restricted.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.apps.restricted.list)
- `/admin.conversations.archive` — `POST`
- `/admin.conversations.convertToPrivate` — `POST`
- `/admin.conversations.create` — `POST`
- `/admin.conversations.delete` — `POST`
- `/admin.conversations.disconnectShared` — `POST`
- `/admin.conversations.ekm.listOriginalConnectedChannelInfo` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.conversations.ekm.listOriginalConnectedChannelInfo)
- `/admin.conversations.getConversationPrefs` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.conversations.getConversationPrefs)
- `/admin.conversations.getTeams` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.conversations.getTeams)
- `/admin.conversations.invite` — `POST`
- `/admin.conversations.rename` — `POST`
- `/admin.conversations.restrictAccess.addGroup` — `POST`
- `/admin.conversations.restrictAccess.listGroups` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.conversations.restrictAccess.listGroups)
- `/admin.conversations.restrictAccess.removeGroup` — `POST`
- `/admin.conversations.search` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.conversations.search)
- `/admin.conversations.setConversationPrefs` — `POST`
- `/admin.conversations.setTeams` — `POST`
- `/admin.conversations.unarchive` — `POST`
- `/admin.emoji.add` — `POST`
- `/admin.emoji.addAlias` — `POST`
- `/admin.emoji.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.emoji.list)
- `/admin.emoji.remove` — `POST`
- `/admin.emoji.rename` — `POST`
- `/admin.Invite Requests.approve` — `POST`
- `/admin.Invite Requests.approved.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.Invite Requests.approved.list)
- `/admin.Invite Requests.denied.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.Invite Requests.denied.list)
- `/admin.Invite Requests.deny` — `POST`
- `/admin.Invite Requests.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.Invite Requests.list)
- `/admin.teams.admins.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.teams.admins.list)
- `/admin.teams.create` — `POST`
- `/admin.teams.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.teams.list)
- `/admin.teams.owners.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.teams.owners.list)
- `/admin.teams.settings.info` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.teams.settings.info)
- `/admin.teams.settings.setDefaultChannels` — `POST`
- `/admin.teams.settings.setDescription` — `POST`
- `/admin.teams.settings.setDiscoverability` — `POST`
- `/admin.teams.settings.setIcon` — `POST`
- `/admin.teams.settings.setName` — `POST`
- `/admin.Use Groups.addChannels` — `POST`
- `/admin.Use Groups.addTeams` — `POST`
- `/admin.Use Groups.listChannels` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.Use Groups.listChannels)
- `/admin.Use Groups.removeChannels` — `POST`
- `/admin.users.assign` — `POST`
- `/admin.users.invite` — `POST`
- `/admin.users.list` — [`GET`](https://mocks.naftiko.net/rest/slack-admin-api/1.0.0/admin.users.list)
- `/admin.users.remove` — `POST`
- `/admin.users.session.invalidate` — `POST`
- `/admin.users.session.reset` — `POST`
- `/admin.users.setAdmin` — `POST`
- `/admin.users.setExpiration` — `POST`
- `/admin.users.setOwner` — `POST`
- `/admin.users.setRegular` — `POST`

</details>

<details><summary><strong>slack-apps-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-apps-api/1.0.0"><code>slack-apps-api/1.0.0</code></a> · 8 paths · <code>slack-apps-openapi.yml</code></summary>

- `/apps.event.authorizations.list` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.event.authorizations.list)
- `/apps.permissions.info` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.info)
- `/apps.permissions.request` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.request)
- `/apps.permissions.resources.list` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.resources.list)
- `/apps.permissions.scopes.list` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.scopes.list)
- `/apps.permissions.users.list` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.users.list)
- `/apps.permissions.users.request` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.permissions.users.request)
- `/apps.uninstall` — [`GET`](https://mocks.naftiko.net/rest/slack-apps-api/1.0.0/apps.uninstall)

</details>

<details><summary><strong>slack-auth-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-auth-api/1.0.0"><code>slack-auth-api/1.0.0</code></a> · 2 paths · <code>slack-auth-openapi.yml</code></summary>

- `/auth.revoke` — [`GET`](https://mocks.naftiko.net/rest/slack-auth-api/1.0.0/auth.revoke)
- `/auth.test` — [`GET`](https://mocks.naftiko.net/rest/slack-auth-api/1.0.0/auth.test)

</details>

<details><summary><strong>slack-bots-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-bots-api/1.0.0"><code>slack-bots-api/1.0.0</code></a> · 1 paths · <code>slack-bots-openapi.yml</code></summary>

- `/bots.info` — [`GET`](https://mocks.naftiko.net/rest/slack-bots-api/1.0.0/bots.info)

</details>

<details><summary><strong>slack-calls-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-calls-api/1.0.0"><code>slack-calls-api/1.0.0</code></a> · 6 paths · <code>slack-calls-openapi.yml</code></summary>

- `/calls.add` — `POST`
- `/calls.end` — `POST`
- `/calls.info` — [`GET`](https://mocks.naftiko.net/rest/slack-calls-api/1.0.0/calls.info)
- `/calls.update` — `POST`
- `/calls.participants.add` — `POST`
- `/calls.participants.remove` — `POST`

</details>

<details><summary><strong>slack-chat-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-chat-api/1.0.0"><code>slack-chat-api/1.0.0</code></a> · 10 paths · <code>slack-chat-openapi.yml</code></summary>

- `/chat.delete` — `POST`
- `/chat.deleteScheduledMessage` — `POST`
- `/chat.getPermalink` — [`GET`](https://mocks.naftiko.net/rest/slack-chat-api/1.0.0/chat.getPermalink)
- `/chat.meMessage` — `POST`
- `/chat.postEphemeral` — `POST`
- `/chat.postMessage` — `POST`
- `/chat.scheduleMessage` — `POST`
- `/chat.scheduledMessages.list` — [`GET`](https://mocks.naftiko.net/rest/slack-chat-api/1.0.0/chat.scheduledMessages.list)
- `/chat.unfurl` — `POST`
- `/chat.update` — `POST`

</details>

<details><summary><strong>slack-conversations-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0"><code>slack-conversations-api/1.0.0</code></a> · 18 paths · <code>slack-conversations-openapi.yml</code></summary>

- `/conversations.archive` — `POST`
- `/conversations.close` — `POST`
- `/conversations.create` — `POST`
- `/conversations.history` — [`GET`](https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0/conversations.history)
- `/conversations.info` — [`GET`](https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0/conversations.info)
- `/conversations.invite` — `POST`
- `/conversations.join` — `POST`
- `/conversations.kick` — `POST`
- `/conversations.leave` — `POST`
- `/conversations.list` — [`GET`](https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0/conversations.list)
- `/conversations.mark` — `POST`
- `/conversations.members` — [`GET`](https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0/conversations.members)
- `/conversations.open` — `POST`
- `/conversations.rename` — `POST`
- `/conversations.replies` — [`GET`](https://mocks.naftiko.net/rest/slack-conversations-api/1.0.0/conversations.replies)
- `/conversations.setPurpose` — `POST`
- `/conversations.setTopic` — `POST`
- `/conversations.unarchive` — `POST`

</details>

<details><summary><strong>slack-dialog-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-dialog-api/1.0.0"><code>slack-dialog-api/1.0.0</code></a> · 1 paths · <code>slack-dialog-openapi.yml</code></summary>

- `/dialog.open` — [`GET`](https://mocks.naftiko.net/rest/slack-dialog-api/1.0.0/dialog.open)

</details>

<details><summary><strong>slack-dnd-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-dnd-api/1.0.0"><code>slack-dnd-api/1.0.0</code></a> · 5 paths · <code>slack-dnd-openapi.yml</code></summary>

- `/dnd.endDnd` — `POST`
- `/dnd.endSnooze` — `POST`
- `/dnd.info` — [`GET`](https://mocks.naftiko.net/rest/slack-dnd-api/1.0.0/dnd.info)
- `/dnd.setSnooze` — `POST`
- `/dnd.teamInfo` — [`GET`](https://mocks.naftiko.net/rest/slack-dnd-api/1.0.0/dnd.teamInfo)

</details>

<details><summary><strong>slack-files-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-files-api/1.0.0"><code>slack-files-api/1.0.0</code></a> · 13 paths · <code>slack-files-openapi.yml</code></summary>

- `/files.comments.delete` — `POST`
- `/files.delete` — `POST`
- `/files.info` — [`GET`](https://mocks.naftiko.net/rest/slack-files-api/1.0.0/files.info)
- `/files.list` — [`GET`](https://mocks.naftiko.net/rest/slack-files-api/1.0.0/files.list)
- `/files.upload` — `POST`
- `/files.revokePublicURL` — `POST`
- `/files.sharedPublicURL` — `POST`
- `/files.remote.add` — `POST`
- `/files.remote.info` — [`GET`](https://mocks.naftiko.net/rest/slack-files-api/1.0.0/files.remote.info)
- `/files.remote.list` — [`GET`](https://mocks.naftiko.net/rest/slack-files-api/1.0.0/files.remote.list)
- `/files.remote.remove` — `POST`
- `/files.remote.share` — [`GET`](https://mocks.naftiko.net/rest/slack-files-api/1.0.0/files.remote.share)
- `/files.remote.update` — `POST`

</details>

<details><summary><strong>slack-migration-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-migration-api/1.0.0"><code>slack-migration-api/1.0.0</code></a> · 1 paths · <code>slack-migration-openapi.yml</code></summary>

- `/migration.exchange` — [`GET`](https://mocks.naftiko.net/rest/slack-migration-api/1.0.0/migration.exchange)

</details>

<details><summary><strong>slack-oauth-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-oauth-api/1.0.0"><code>slack-oauth-api/1.0.0</code></a> · 3 paths · <code>slack-oauth-openapi.yml</code></summary>

- `/oauth.access` — [`GET`](https://mocks.naftiko.net/rest/slack-oauth-api/1.0.0/oauth.access)
- `/oauth.token` — [`GET`](https://mocks.naftiko.net/rest/slack-oauth-api/1.0.0/oauth.token)
- `/oauth.v2.access` — [`GET`](https://mocks.naftiko.net/rest/slack-oauth-api/1.0.0/oauth.v2.access)

</details>

<details><summary><strong>slack-pins-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-pins-api/1.0.0"><code>slack-pins-api/1.0.0</code></a> · 3 paths · <code>slack-pins-openapi.yml</code></summary>

- `/pins.add` — `POST`
- `/pins.list` — [`GET`](https://mocks.naftiko.net/rest/slack-pins-api/1.0.0/pins.list)
- `/pins.remove` — `POST`

</details>

<details><summary><strong>slack-reactions-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-reactions-api/1.0.0"><code>slack-reactions-api/1.0.0</code></a> · 4 paths · <code>slack-reactions-openapi.yml</code></summary>

- `/reactions.add` — `POST`
- `/reactions.get` — [`GET`](https://mocks.naftiko.net/rest/slack-reactions-api/1.0.0/reactions.get)
- `/reactions.list` — [`GET`](https://mocks.naftiko.net/rest/slack-reactions-api/1.0.0/reactions.list)
- `/reactions.remove` — `POST`

</details>

<details><summary><strong>slack-reminders-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-reminders-api/1.0.0"><code>slack-reminders-api/1.0.0</code></a> · 5 paths · <code>slack-reminders-openapi.yml</code></summary>

- `/reminders.add` — `POST`
- `/reminders.complete` — `POST`
- `/reminders.delete` — `POST`
- `/reminders.info` — [`GET`](https://mocks.naftiko.net/rest/slack-reminders-api/1.0.0/reminders.info)
- `/reminders.list` — [`GET`](https://mocks.naftiko.net/rest/slack-reminders-api/1.0.0/reminders.list)

</details>

<details><summary><strong>slack-rtm-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-rtm-api/1.0.0"><code>slack-rtm-api/1.0.0</code></a> · 1 paths · <code>slack-rtm-openapi.yml</code></summary>

- `/rtm.connect` — [`GET`](https://mocks.naftiko.net/rest/slack-rtm-api/1.0.0/rtm.connect)

</details>

<details><summary><strong>slack-search-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-search-api/1.0.0"><code>slack-search-api/1.0.0</code></a> · 1 paths · <code>slack-search-openapi.yml</code></summary>

- `/search.messages` — [`GET`](https://mocks.naftiko.net/rest/slack-search-api/1.0.0/search.messages)

</details>

<details><summary><strong>slack-stars-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-stars-api/1.0.0"><code>slack-stars-api/1.0.0</code></a> · 3 paths · <code>slack-stars-openapi.yml</code></summary>

- `/stars.add` — `POST`
- `/stars.list` — [`GET`](https://mocks.naftiko.net/rest/slack-stars-api/1.0.0/stars.list)
- `/stars.remove` — `POST`

</details>

<details><summary><strong>slack-team-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-team-api/1.0.0"><code>slack-team-api/1.0.0</code></a> · 5 paths · <code>slack-team-openapi.yml</code></summary>

- `/team.accessLogs` — [`GET`](https://mocks.naftiko.net/rest/slack-team-api/1.0.0/team.accessLogs)
- `/team.billableInfo` — [`GET`](https://mocks.naftiko.net/rest/slack-team-api/1.0.0/team.billableInfo)
- `/team.info` — [`GET`](https://mocks.naftiko.net/rest/slack-team-api/1.0.0/team.info)
- `/team.integrationLogs` — [`GET`](https://mocks.naftiko.net/rest/slack-team-api/1.0.0/team.integrationLogs)
- `/team.profile.get` — [`GET`](https://mocks.naftiko.net/rest/slack-team-api/1.0.0/team.profile.get)

</details>

<details><summary><strong>slack-tests-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-tests-api/1.0.0"><code>slack-tests-api/1.0.0</code></a> · 1 paths · <code>slack-test-api-openapi.yml</code></summary>

- `/api.test` — [`GET`](https://mocks.naftiko.net/rest/slack-tests-api/1.0.0/api.test)

</details>

<details><summary><strong>slack-user-groups-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-user-groups-api/1.0.0"><code>slack-user-groups-api/1.0.0</code></a> · 7 paths · <code>slack-usergroups-openapi.yml</code></summary>

- `/Use Groups.create` — `POST`
- `/Use Groups.disable` — `POST`
- `/Use Groups.enable` — `POST`
- `/Use Groups.list` — [`GET`](https://mocks.naftiko.net/rest/slack-user-groups-api/1.0.0/Use Groups.list)
- `/Use Groups.update` — `POST`
- `/Use Groups.users.list` — [`GET`](https://mocks.naftiko.net/rest/slack-user-groups-api/1.0.0/Use Groups.users.list)
- `/Use Groups.users.update` — `POST`

</details>

<details><summary><strong>slack-users-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-users-api/1.0.0"><code>slack-users-api/1.0.0</code></a> · 12 paths · <code>slack-users-openapi.yml</code></summary>

- `/users.conversations` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.conversations)
- `/users.deletePhoto` — `POST`
- `/users.getPresence` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.getPresence)
- `/users.identity` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.identity)
- `/users.info` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.info)
- `/users.list` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.list)
- `/users.lookupByEmail` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.lookupByEmail)
- `/users.profile.get` — [`GET`](https://mocks.naftiko.net/rest/slack-users-api/1.0.0/users.profile.get)
- `/users.profile.set` — `POST`
- `/users.setActive` — `POST`
- `/users.setPhoto` — `POST`
- `/users.setPresence` — `POST`

</details>

<details><summary><strong>slack-views-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-views-api/1.0.0"><code>slack-views-api/1.0.0</code></a> · 4 paths · <code>slack-views-openapi.yml</code></summary>

- `/views.open` — [`GET`](https://mocks.naftiko.net/rest/slack-views-api/1.0.0/views.open)
- `/views.publish` — [`GET`](https://mocks.naftiko.net/rest/slack-views-api/1.0.0/views.publish)
- `/views.push` — [`GET`](https://mocks.naftiko.net/rest/slack-views-api/1.0.0/views.push)
- `/views.update` — [`GET`](https://mocks.naftiko.net/rest/slack-views-api/1.0.0/views.update)

</details>

<details><summary><strong>slack-workflows-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/slack-workflows-api/1.0.0"><code>slack-workflows-api/1.0.0</code></a> · 3 paths · <code>slack-workflows-openapi.yml</code></summary>

- `/workflows.stepCompleted` — [`GET`](https://mocks.naftiko.net/rest/slack-workflows-api/1.0.0/workflows.stepCompleted)
- `/workflows.stepFailed` — [`GET`](https://mocks.naftiko.net/rest/slack-workflows-api/1.0.0/workflows.stepFailed)
- `/workflows.updateStep` — [`GET`](https://mocks.naftiko.net/rest/slack-workflows-api/1.0.0/workflows.updateStep)

</details>

<details><summary><strong>openai-threads-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/openai-threads-api/1.0.0"><code>openai-threads-api/1.0.0</code></a> · 11 paths · <code>threads-openapi-original.yml</code></summary>

- `/threads` — `POST`
- `/threads/{thread_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}) `POST` `DELETE`
- `/threads/{thread_id}/messages` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/messages) `POST`
- `/threads/{thread_id}/messages/{message_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/messages/{message_id}) `POST`
- `/threads/{thread_id}/runs` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/runs) `POST`
- `/threads/{thread_id}/runs/{run_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/runs/{run_id}) `POST`
- `/threads/{thread_id}/runs/{run_id}/cancel` — `POST`
- `/threads/{thread_id}/runs/{run_id}/submit_tool_outputs` — `POST`
- `/threads/{thread_id}/runs/{run_id}/steps` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/runs/{run_id}/steps)
- `/threads/{thread_id}/runs/{run_id}/steps/{step_id}` — [`GET`](https://mocks.naftiko.net/rest/openai-threads-api/1.0.0/threads/{thread_id}/runs/{run_id}/steps/{step_id})
- `/threads/runs` — `POST`

</details>

<details><summary><strong>webflow-token-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-token-api/1.0.0"><code>webflow-token-api/1.0.0</code></a> · 2 paths · <code>token-openapi-original.yml</code></summary>

- `/token/authorized_by` — [`GET`](https://mocks.naftiko.net/rest/webflow-token-api/1.0.0/token/authorized_by)
- `/token/introspect` — [`GET`](https://mocks.naftiko.net/rest/webflow-token-api/1.0.0/token/introspect)

</details>

<details><summary><strong>webflow-webhooks-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-webhooks-api/1.0.0"><code>webflow-webhooks-api/1.0.0</code></a> · 2 paths · <code>webhooks-openapi-original.yml</code></summary>

- `/sites/{site_id}/webhooks` — [`GET`](https://mocks.naftiko.net/rest/webflow-webhooks-api/1.0.0/sites/{site_id}/webhooks) `POST`
- `/webhooks/{webhook_id}` — [`GET`](https://mocks.naftiko.net/rest/webflow-webhooks-api/1.0.0/webhooks/{webhook_id}) `DELETE`

</details>

<details><summary><strong>webflow-workspaces-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/webflow-workspaces-api/1.0.0"><code>webflow-workspaces-api/1.0.0</code></a> · 2 paths · <code>workspaces-openapi-original.yml</code></summary>

- `/workspaces/{workspace_id}/sites` — `POST`
- `/workspaces/{workspace_id_or_slug}/audit_logs` — [`GET`](https://mocks.naftiko.net/rest/webflow-workspaces-api/1.0.0/workspaces/{workspace_id_or_slug}/audit_logs)

</details>

<details><summary><strong>youtube-analytics-api</strong> · v2.0.0 · <a href="https://mocks.naftiko.net/rest/youtube-analytics-api/2.0.0"><code>youtube-analytics-api/2.0.0</code></a> · 5 paths · <code>youtube-analytics-openapi-original.yml</code></summary>

- `/reports` — [`GET`](https://mocks.naftiko.net/rest/youtube-analytics-api/2.0.0/reports)
- `/groups` — [`GET`](https://mocks.naftiko.net/rest/youtube-analytics-api/2.0.0/groups) `POST`
- `/groups/{groupId}` — [`GET`](https://mocks.naftiko.net/rest/youtube-analytics-api/2.0.0/groups/{groupId}) `PUT` `DELETE`
- `/groupItems` — [`GET`](https://mocks.naftiko.net/rest/youtube-analytics-api/2.0.0/groupItems) `POST`
- `/groupItems/{itemId}` — `DELETE`

</details>

<details><summary><strong>youtube-data-api</strong> · v3.0.0 · <a href="https://mocks.naftiko.net/rest/youtube-data-api/3.0.0"><code>youtube-data-api/3.0.0</code></a> · 12 paths · <code>youtube-data-openapi-original.yml</code></summary>

- `/search` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/search)
- `/videos` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/videos) `POST`
- `/videos/{videoId}` — `PUT` `DELETE`
- `/channels` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/channels)
- `/playlists` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/playlists) `POST`
- `/playlists/{playlistId}` — `PUT` `DELETE`
- `/playlistItems` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/playlistItems) `POST`
- `/playlistItems/{playlistItemId}` — `DELETE`
- `/subscriptions` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/subscriptions) `POST`
- `/subscriptions/{subscriptionId}` — `DELETE`
- `/commentThreads` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/commentThreads)
- `/captions` — [`GET`](https://mocks.naftiko.net/rest/youtube-data-api/3.0.0/captions)

</details>

<details><summary><strong>zoom-account-management-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-account-management-api/1.0.0"><code>zoom-account-management-api/1.0.0</code></a> · 10 paths · <code>zoom-account-openapi-original.yml</code></summary>

- `/ma/account/create` — `POST`
- `/ma/account/get` — `POST`
- `/ma/account/list` — `POST`
- `/ma/account/update` — `POST`
- `/ma/account/delete` — `POST`
- `/ma/account/billing/update` — `POST`
- `/ma/account/plan/subscribe` — `POST`
- `/ma/account/plan/add` — `POST`
- `/ma/account/plan/get` — `POST`
- `/ma/account/plan/update` — `POST`

</details>

<details><summary><strong>zoom-chat-messages-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-chat-messages-api/1.0.0"><code>zoom-chat-messages-api/1.0.0</code></a> · 2 paths · <code>zoom-chat-openapi-original.yml</code></summary>

- `/chat/list` — `POST`
- `/chat/get` — `POST`

</details>

<details><summary><strong>zoom-h323sip-device-management-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-h323sip-device-management-api/1.0.0"><code>zoom-h323sip-device-management-api/1.0.0</code></a> · 4 paths · <code>zoom-device-openapi-original.yml</code></summary>

- `/h323/device/create` — `POST`
- `/h323/device/list` — `POST`
- `/h323/device/update` — `POST`
- `/h323/device/delete` — `POST`

</details>

<details><summary><strong>zoom-groups-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-groups-api/1.0.0"><code>zoom-groups-api/1.0.0</code></a> · 8 paths · <code>zoom-group-openapi-original.yml</code></summary>

- `/group/create` — `POST`
- `/group/delete` — `POST`
- `/group/edit` — `POST`
- `/group/get` — `POST`
- `/group/list` — `POST`
- `/group/member/add` — `POST`
- `/group/member/delete` — `POST`
- `/group/member/list` — `POST`

</details>

<details><summary><strong>zoom-instant-messaging-groups-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-instant-messaging-groups-api/1.0.0"><code>zoom-instant-messaging-groups-api/1.0.0</code></a> · 7 paths · <code>zoom-im-openapi-original.yml</code></summary>

- `/im/group/create` — `POST`
- `/im/group/delete` — `POST`
- `/im/group/edit` — `POST`
- `/im/group/get` — `POST`
- `/im/group/list` — `POST`
- `/im/group/member/delete` — `POST`
- `/im/group/member/list` — `POST`

</details>

<details><summary><strong>zoom-meetings-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-meetings-api/1.0.0"><code>zoom-meetings-api/1.0.0</code></a> · 8 paths · <code>zoom-meeting-openapi-original.yml</code></summary>

- `/meeting/create` — `POST`
- `/meeting/delete` — `POST`
- `/meeting/end` — `POST`
- `/meeting/get` — `POST`
- `/meeting/list` — `POST`
- `/meeting/live` — `POST`
- `/meeting/register` — `POST`
- `/meeting/update` — `POST`

</details>

<details><summary><strong>zoom-dashboard-metrics-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-dashboard-metrics-api/1.0.0"><code>zoom-dashboard-metrics-api/1.0.0</code></a> · 9 paths · <code>zoom-metrics-openapi-original.yml</code></summary>

- `/metrics/crc` — `POST`
- `/metrics/im` — `POST`
- `/metrics/meetingdetail` — `POST`
- `/metrics/meetings` — `POST`
- `/metrics/qos` — `POST`
- `/metrics/webinardetail` — `POST`
- `/metrics/webinars` — `POST`
- `/metrics/zoomroomdetail` — `POST`
- `/metrics/zoomrooms` — `POST`

</details>

<details><summary><strong>zoom-cloud-recording-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-cloud-recording-api/1.0.0"><code>zoom-cloud-recording-api/1.0.0</code></a> · 4 paths · <code>zoom-recording-openapi-original.yml</code></summary>

- `/mc/recording/list` — `POST`
- `/recording/delete` — `POST`
- `/recording/get` — `POST`
- `/recording/list` — `POST`

</details>

<details><summary><strong>zoom-report-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-report-api/1.0.0"><code>zoom-report-api/1.0.0</code></a> · 4 paths · <code>zoom-report-openapi-original.yml</code></summary>

- `/report/getaccountreport` — `POST`
- `/report/getaudioreport` — `POST`
- `/report/getdailyreport` — `POST`
- `/report/getuserreport` — `POST`

</details>

<details><summary><strong>zoom-user-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-user-api/1.0.0"><code>zoom-user-api/1.0.0</code></a> · 20 paths · <code>zoom-user-openapi-original.yml</code></summary>

- `/user/assistant/delete` — `POST`
- `/user/assistant/set` — `POST`
- `/user/autocreate` — `POST`
- `/user/checkemail` — `POST`
- `/user/checkzpk` — `POST`
- `/user/create` — `POST`
- `/user/custcreate` — `POST`
- `/user/activate` — `POST`
- `/user/deactivate` — `POST`
- `/user/delete` — `POST`
- `/user/get` — `POST`
- `/user/getbyemail` — `POST`
- `/user/list` — `POST`
- `/user/pending` — `POST`
- `/user/permanentdelete` — `POST`
- `/user/revoketoken` — `POST`
- `/user/scheduleforhost/list` — `POST`
- `/user/ssocreate` — `POST`
- `/user/update` — `POST`
- `/user/updatepassword` — `POST`

</details>

<details><summary><strong>zoom-webinar-api</strong> · v1.0.0 · <a href="https://mocks.naftiko.net/rest/zoom-webinar-api/1.0.0"><code>zoom-webinar-api/1.0.0</code></a> · 17 paths · <code>zoom-webinar-openapi-original.yml</code></summary>

- `/webinar/attendees/list` — `POST`
- `/webinar/create` — `POST`
- `/webinar/delete` — `POST`
- `/webinar/end` — `POST`
- `/webinar/get` — `POST`
- `/webinar/list` — `POST`
- `/webinar/list/registration` — `POST`
- `/webinar/panelists` — `POST`
- `/webinar/polls` — `POST`
- `/webinar/questions` — `POST`
- `/webinar/register` — `POST`
- `/webinar/registrants/approve` — `POST`
- `/webinar/registrants/list` — `POST`
- `/webinar/registration` — `POST`
- `/webinar/registration/cancel` — `POST`
- `/webinar/update` — `POST`
- `/webinar/uuid/list` — `POST`

</details>

<!-- MOCK_ENDPOINTS:END -->
