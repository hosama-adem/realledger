# apps

Reserved for the two web clients. Nothing is built here yet.

| Directory | App | Host |
| --- | --- | --- |
| `apps/web` | Customer app. Owners, accountants, viewers | `app.realledger.app` |
| `apps/admin` | Platform console. RealLedger staff only | `admin.realledger.app` |

Each app is its own Next.js project, with its own deployment and its own token audience. Add them after `docs/realledger-openapi.yaml` is connected to the API. Until then, this folder stays a placeholder.
