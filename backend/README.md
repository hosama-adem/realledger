# backend

The Go API. One module, one process, one package per domain.

```text
backend/
├── cmd/api/          Process entrypoint. Stays thin.
├── internal/         Domain packages. See the table below.
├── migrations/       Ordered SQL. Applied with goose.
└── tests/            Tests that cross more than one package.
```

`go.mod`, the HTTP server, and the first migration arrive with their own issues. This tree is the boundary those issues fill in.

## Packages

| Package | Owns | Hands off to |
| --- | --- | --- |
| `auth` | Credentials, sessions, verification, password reset | `organization` and `user` for the tenant a session belongs to |
| `organization` | Profile and verification status | `platformadmin` sets Verified / Rejected |
| `user` | Members, invitations, company roles, last-owner rule | `platformadmin` for staff, who are not members |
| `customer` | Customer records and duplicate warnings | `transaction` links a payment to a customer |
| `paymentmethod` | Method name, type, presets, active flag | `imports` reads the method a statement belongs to |
| `transaction` | Amount, reference, status events, idempotent create | `ledger` posts the financial effect |
| `ledger` | Accounts, balanced entries, reversals, immutability | Callers send a posting request. They do not write rows |
| `imports` | Upload, parse, templates, fingerprints, history | `reconciliation` matches the accepted lines |
| `reconciliation` | Three-pass match, link, explain, close, reopen | `ledger` when a human confirms a correction |
| `audit` | Append-only company audit log | `platformadmin` keeps a separate staff log |
| `ai` | Read-only tools, facts vs possible explanations | Tool results come from the packages above |
| `platformadmin` | Staff users, MFA, `/admin-api`, break-glass grants | Tenant data stays behind an Owner-approved grant |

## Import rules

- A package may call the neighbor named in **Hands off to**.
- HTTP routing and process startup live in `cmd/api`.
- SQL files live in `migrations`. Queries generated later (sqlc) stay next to the package that owns the table.
- Unit tests sit beside the package (`*_test.go`). `backend/tests` is for flows that need several packages at once.
