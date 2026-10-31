# RealLedger

Payment gateways move money. RealLedger explains it.

RealLedger is a multi-tenant ledger and reconciliation platform for Ethiopian businesses. This repository is the monorepo: one Go API, the product documents, and — when the API contract is stable — two Next.js apps.

The layout below is the map. New code goes in the package that already owns that noun.

## Layout

```text
realledger/
├── backend/                 Go API
│   ├── cmd/api/             Process entrypoint
│   ├── internal/            One package per domain
│   ├── migrations/          Numbered SQL migrations
│   └── tests/               Cross-package tests
├── docs/                    PRD, plans, OpenAPI contract
├── tests/fixtures/          Anonymized statement files
├── apps/                    Reserved. Customer app + admin console
├── docker-compose.yml       Local PostgreSQL 16
├── .env.example             Env placeholders (copy to .env)
├── Makefile                 up / down / psql / run / test
├── README.md
├── .gitignore
└── LICENSE
```

## Local database

Needs Docker Desktop (or Docker Engine) with Compose v2+, and `make`.

```bash
cp .env.example .env   # once; make up also creates .env if missing
make up                # starts postgres:16 and waits until healthy
make psql              # SQL shell as realledger / realledger
make down              # stop containers; data stays in the named volume
```

Host port defaults to **5433** (see `POSTGRES_PORT` in `.env`) so RealLedger can sit next to other local Postgres containers on 5432. Change the port in `.env` if you prefer.

## API server

Needs Go 1.22+ and a running database (`make up`).

```bash
make run               # loads .env, listens on :8080
curl localhost:8080/health   # liveness — process is up
curl localhost:8080/ready    # readiness — can reach Postgres
```

`/health` never touches the database. `/ready` returns 503 if Postgres is down. Ctrl+C shuts the process down cleanly.

## Continuous integration

Every push and pull request runs [`.github/workflows/ci.yml`](.github/workflows/ci.yml):

| Check | What it does |
| --- | --- |
| **Go** | `go vet`, `go test`, `golangci-lint` in `backend/` |
| **Secrets** | gitleaks scan (blocks real secrets; placeholders in `.env.example` are allowed) |

Dependabot opens weekly PRs for Go modules and GitHub Actions. `main` expects these checks to stay green before merge.

Locally:

```bash
make vet
make test
make lint   # needs golangci-lint installed
```

These paths are named now and filled on their own day:

| Path | When | What lands there |
| --- | --- | --- |
| `docker-compose.yml`, `.env.example`, `Makefile` | Day 2 | Local PostgreSQL 16 *(done)* |
| `backend/cmd/api` | Day 3 | Go server, `/health`, `/ready` *(done)* |
| `.github/workflows/ci.yml` | Day 4 | CI, Dependabot, gitleaks *(done)* |
| `tests/fixtures` | Day 5 | Anonymized Telebirr, Chapa, and bank files |
| `docs/database-erd.md`, `docs/database-naming-rules.md` | Day 6 | Schema map and naming *(done)* |
| `backend/migrations` | Day 8 | goose migrations and sqlc |
| `apps/web`, `apps/admin` | After the contract is stable | Next.js customer app and platform console |

## Who owns what

| Path | Owns |
| --- | --- |
| `backend/cmd/api` | Configuration, HTTP server, graceful shutdown |
| `backend/internal/auth` | Register, login, argon2id passwords, verification, refresh tokens |
| `backend/internal/organization` | Tenant profile and verification status |
| `backend/internal/user` | Members, invitations, Owner / Accountant / Viewer |
| `backend/internal/customer` | Customer records, `+251` phones, soft delete |
| `backend/internal/paymentmethod` | Channels (Telebirr, Chapa, bank, cash). No provider secrets |
| `backend/internal/transaction` | Expected payments, status events, idempotent creates |
| `backend/internal/ledger` | Integer minor units, balanced postings, reversals |
| `backend/internal/imports` | CSV/Excel statements, column templates, fingerprints |
| `backend/internal/reconciliation` | Expected vs actual, three-pass match, period close |
| `backend/internal/audit` | Append-only company audit log |
| `backend/internal/ai` | Read-only tools. The backend computes every number |
| `backend/internal/platformadmin` | Staff identity, `/admin-api`, break-glass support access |
| `backend/migrations` | Schema changes, one file per change |
| `backend/tests` | Tenant isolation, ledger invariants, HTTP flows |
| `tests/fixtures` | Anonymized statement files for import tests |
| `apps/web` | Customer app (`app.realledger.app`), later |
| `apps/admin` | Platform console (`admin.realledger.app`), later |
| `docs` | Product scope and the HTTP contract |

Package boundaries are spelled out again in [`backend/README.md`](backend/README.md).

## Documents

| File | Decides |
| --- | --- |
| [`docs/RealLedger-PRD-v2.md`](docs/RealLedger-PRD-v2.md) | Scope, roles, data model, stack |
| [`docs/RealLedger-Backend-Plan.md`](docs/RealLedger-Backend-Plan.md) | Backend work, one issue per day |
| [`docs/RealLedger-Roadmap-and-Issues.md`](docs/RealLedger-Roadmap-and-Issues.md) | 90-day milestones and definition of done |
| [`docs/realledger-openapi.yaml`](docs/realledger-openapi.yaml) | HTTP contract. Handlers follow this file |
| [`docs/database-erd.md`](docs/database-erd.md) | MVP tables, relationships, tenancy marks |
| [`docs/database-naming-rules.md`](docs/database-naming-rules.md) | UUID, UTC, BIGINT money, snake_case rules |

## Rules that keep later days in place

1. Domain behavior goes in the `internal/` package that already owns that noun.
2. `cmd/api` starts the process and wires dependencies. Business rules stay in `internal/`.
3. Money is an integer in minor units (`105000` = 1,050.00 ETB). `ledger` is the only package that posts ledger rows.
4. `organization_id` comes from the authenticated session.
5. Secrets live in the environment. `.env` is gitignored. `.env.example` is the file that gets committed.
6. Files in `tests/fixtures` are anonymized. Unredacted statements stay in `tests/fixtures/raw/`, which git ignores.

## License

[MIT](LICENSE)
