# Database naming rules

Companion to [database-erd.md](database-erd.md) and PRD §8. Day 8+ migrations and sqlc follow these rules without debate.

## 1. Locked product decisions

| Topic | Decision | Why |
| --- | --- | --- |
| IDs | `uuid` primary keys, default `gen_random_uuid()` | Opaque, merge-safe, matches OpenAPI `format: uuid` |
| Time | `timestamptz` always; store and compute in **UTC** | No ambiguous local offsets in the ledger |
| Money | `bigint` **minor units** + `currency char(3)` | `105000` = 1,050.00 ETB; never `float` / `numeric` for money math |
| Tenancy | `organization_id uuid NOT NULL` on every tenant-owned table | Set from the auth session; never trusted from the request body |
| Soft delete | Prefer `deleted_at` over hard delete for business records | Customers (and similar) stay recoverable and auditable |
| Ledger | Insert-only entries; corrections = reversal + new posting | Immutability is a hard product rule |

Display of Ethiopian calendar is a **UI** concern. The database keeps Gregorian `date` / UTC `timestamptz`.

## 2. Naming

| Thing | Rule | Examples |
| --- | --- | --- |
| Tables | `snake_case`, **plural** | `payment_methods`, `ledger_entries` |
| Columns | `snake_case` | `amount_minor`, `created_at` |
| Primary key | `id` | `customers.id` |
| Foreign key | `<singular>_id` | `customer_id`, `payment_method_id` |
| Booleans | `is_` / `has_` prefix | `is_reversed`, `is_system` |
| Timestamps | `*_at` | `created_at`, `deleted_at`, `closed_at` |
| Dates (calendar day) | `*_date` or period bounds | `transaction_date`, `period_start` |
| Money columns | `*_minor` | `amount_minor`, `debit_minor`, `credit_minor` |
| Status / type enums | `text` (+ check constraint) or Postgres enum | Prefer `text` + check for early migrations |
| JSON documents | `jsonb` | `column_map`, `tool_payload` |
| Fingerprints / hashes | `text` (hex) or `bytea` | `fingerprint` SHA-256 hex is fine for MVP |

### Platform vs tenant

- Tenant tables: plain names (`users`, `audit_logs`).
- Platform tables: `platform_` prefix (`platform_users`, `platform_audit_logs`).
- Never reuse a tenant table for staff identity.

## 3. `organization_id` rules

1. Every **ORG** table in the ERD includes `organization_id uuid NOT NULL REFERENCES organizations(id)`.
2. Application code sets it from the authenticated tenant context.
3. Clients never send `organization_id` in create/update bodies (OpenAPI already forbids this pattern).
4. Indexes that enforce uniqueness are **scoped**: `(organization_id, …)`, never global uniqueness for tenant data.
5. PostgreSQL Row-Level Security (Day 19) will also key off `organization_id`.

## 4. Indexes (baseline expectations)

Add concrete indexes in migrations when the table lands. Defaults:

- PK on `id`
- Index on `organization_id` for every tenant table
- Composite uniques called out in the ERD (customer reference, transaction reference)
- Foreign keys indexed when used in list filters (`transaction_id`, `statement_import_id`, …)

## 5. Audit and immutability

| Table class | Mutability |
| --- | --- |
| `ledger_entries` | **No** update/delete (DB trigger) |
| `audit_logs`, `platform_audit_logs` | **Append-only** |
| `transaction_events` | **Append-only** (status history) |
| Soft-deletable business rows | `UPDATE` sets `deleted_at`; no hard delete in MVP APIs |

## 6. sqlc / goose conventions (preview for Day 8)

- Migration files: `YYYYMMDDHHMMSS_description.sql` (goose timestamp) or sequential — pick one style on Day 8 and keep it.
- One logical change per migration.
- sqlc query files live next to the owning package later; table names stay plural `snake_case` so generated Go names stay predictable.
- Go money fields map to `int64` (`amount_minor`), never `float64`.

## 7. What not to do

- Do not store provider API keys or bank passwords (PRD non-goal).
- Do not use `float4` / `float8` / `money` / `numeric` for ledger amounts.
- Do not put platform staff in `organization_members`.
- Do not create Phase-2 tables (`provider_integrations`, …) in M1 migrations.
