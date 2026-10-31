# Database ERD (MVP)

Companion to [RealLedger-PRD-v2.md](RealLedger-PRD-v2.md) §8 and [database-naming-rules.md](database-naming-rules.md).

This is the schema map migrations (Day 8+) must follow. Column lists here are the **core** fields — not every optional attribute.

## Locked decisions (see naming rules for detail)

| Decision | Choice |
| --- | --- |
| Primary keys | `uuid` (`gen_random_uuid()`) |
| Timestamps | `timestamptz`, stored and compared in **UTC** |
| Money | `bigint` minor units + `currency` (`char(3)`), never floats |
| Tenancy | `organization_id uuid NOT NULL` on every tenant-owned table |
| Soft delete | `deleted_at timestamptz NULL` where the PRD requires it (e.g. customers) |

## Tenancy legend

| Mark | Meaning |
| --- | --- |
| **ORG** | Tenant-owned — must include `organization_id` (from the session, never from the client body) |
| **ROOT** | The tenant itself (`organizations`) |
| **IDENTITY** | Login identity; scoped to a company through membership, not a direct `organization_id` |
| **PLATFORM** | RealLedger staff only — separate from tenant tables |

---

## 1. Identity and tenancy

```mermaid
erDiagram
  organizations ||--o{ organization_members : has
  organizations ||--o{ invitations : has
  users ||--o{ organization_members : joins
  users ||--o{ invitations : invited_as

  organizations {
    uuid id PK "ROOT"
    text name
    text business_type
    text country
    text email
    text phone
    text verification_status
    timestamptz created_at
    timestamptz updated_at
  }

  users {
    uuid id PK "IDENTITY"
    text email
    text phone
    text password_hash
    boolean email_verified
    boolean phone_verified
    timestamptz created_at
  }

  organization_members {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid user_id FK
    text role "owner|accountant|viewer"
    timestamptz created_at
  }

  invitations {
    uuid id PK "ORG"
    uuid organization_id FK
    text email
    text role
    text token_hash
    timestamptz expires_at
    timestamptz accepted_at
    uuid invited_by FK
  }
```

---

## 2. Customers, payment methods, transactions

```mermaid
erDiagram
  organizations ||--o{ customers : owns
  organizations ||--o{ payment_methods : owns
  organizations ||--o{ transactions : owns
  organizations ||--o{ transaction_events : owns
  organizations ||--o{ categories : owns
  customers ||--o{ transactions : "optional"
  payment_methods ||--o{ transactions : used_on
  transactions ||--o{ transaction_events : records
  transactions ||--o| transactions : "reversal_of"
  categories ||--o{ transactions : "optional"

  customers {
    uuid id PK "ORG"
    uuid organization_id FK
    text name
    text phone "+251 normalized"
    text email
    text reference "unique per org"
    text notes
    timestamptz deleted_at "soft delete"
    timestamptz created_at
  }

  payment_methods {
    uuid id PK "ORG"
    uuid organization_id FK
    text name
    text type "mobile_money|bank|gateway|cash|other"
    text description
    text status "active|inactive"
    timestamptz created_at
  }

  transactions {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid customer_id FK "nullable"
    uuid payment_method_id FK
    bigint amount_minor
    char currency "ETB"
    text reference "unique per org+method"
    date transaction_date
    text status
    text source "manual|import|api"
    uuid category_id FK "nullable"
    uuid reversal_of_id FK "nullable"
    boolean is_reversed
    uuid created_by FK
    timestamptz created_at
  }

  transaction_events {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid transaction_id FK
    text from_status
    text to_status
    uuid actor_user_id FK
    timestamptz created_at
  }

  categories {
    uuid id PK "ORG"
    uuid organization_id FK
    text name
    timestamptz created_at
  }
```

**Uniques (tenant-safe):**

- `customers (organization_id, reference)` where not soft-deleted
- `transactions (organization_id, payment_method_id, reference)`

---

## 3. Ledger (immutable)

```mermaid
erDiagram
  organizations ||--o{ ledger_accounts : owns
  organizations ||--o{ ledger_entries : owns
  transactions ||--o{ ledger_entries : posts
  ledger_accounts ||--o{ ledger_entries : books

  ledger_accounts {
    uuid id PK "ORG"
    uuid organization_id FK
    text code
    text name
    text account_type "asset|liability|equity|revenue|expense"
    boolean is_system
    timestamptz created_at
  }

  ledger_entries {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid ledger_account_id FK
    uuid transaction_id FK
    uuid posting_id "groups balanced legs"
    bigint debit_minor
    bigint credit_minor
    char currency
    text memo
    timestamptz created_at
  }
```

**Invariants (enforced later with constraints + triggers):**

- No `UPDATE` / `DELETE` on `ledger_entries` (and likely `ledger_accounts` once posted against)
- Per `posting_id`: `SUM(debit_minor) = SUM(credit_minor)`
- Exactly one of debit/credit is non-zero per row (or allow both zero only if rejected)

---

## 4. Imports

```mermaid
erDiagram
  organizations ||--o{ import_templates : owns
  organizations ||--o{ statement_imports : owns
  organizations ||--o{ statement_lines : owns
  payment_methods ||--o{ import_templates : maps
  payment_methods ||--o{ statement_imports : for
  statement_imports ||--o{ statement_lines : contains

  import_templates {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid payment_method_id FK
    text name
    jsonb column_map
    timestamptz created_at
  }

  statement_imports {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid payment_method_id FK
    uuid template_id FK "nullable"
    text file_name
    text status "pending|processing|completed|failed"
    int rows_accepted
    int rows_rejected
    uuid created_by FK
    timestamptz created_at
  }

  statement_lines {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid statement_import_id FK
    text external_reference
    bigint amount_minor
    char currency
    date value_date
    text raw_description
    text fingerprint "sha256 method+ref+amount+date"
    text status "accepted|rejected|duplicate"
    timestamptz created_at
  }
```

---

## 5. Reconciliation

```mermaid
erDiagram
  organizations ||--o{ reconciliations : owns
  organizations ||--o{ reconciliation_items : owns
  organizations ||--o{ reconciliation_matches : owns
  reconciliations ||--o{ reconciliation_items : lists
  reconciliations ||--o{ reconciliation_matches : produces
  transactions ||--o{ reconciliation_items : "expected side"
  statement_lines ||--o{ reconciliation_items : "actual side"

  reconciliations {
    uuid id PK "ORG"
    uuid organization_id FK
    date period_start
    date period_end
    text status "open|closed"
    uuid created_by FK
    uuid closed_by FK "nullable"
    timestamptz closed_at
    timestamptz created_at
  }

  reconciliation_items {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid reconciliation_id FK
    text side "expected|actual"
    uuid transaction_id FK "nullable"
    uuid statement_line_id FK "nullable"
    text match_state "unmatched|matched|explained"
    text explanation
  }

  reconciliation_matches {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid reconciliation_id FK
    uuid expected_item_id FK
    uuid actual_item_id FK
    text pass "exact|window|fuzzy|manual"
    numeric confidence "nullable"
    timestamptz created_at
  }
```

---

## 6. Audit, AI, support access

```mermaid
erDiagram
  organizations ||--o{ audit_logs : owns
  organizations ||--o{ ai_conversations : owns
  organizations ||--o{ ai_messages : owns
  organizations ||--o{ support_access_grants : owns
  ai_conversations ||--o{ ai_messages : contains

  audit_logs {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid actor_user_id FK "nullable"
    text action
    text resource_type
    uuid resource_id
    jsonb before_summary
    jsonb after_summary
    inet ip
    timestamptz created_at
  }

  ai_conversations {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid user_id FK
    text title
    timestamptz created_at
  }

  ai_messages {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid conversation_id FK
    text role "user|assistant|tool"
    text content
    jsonb tool_payload "nullable"
    timestamptz created_at
  }

  support_access_grants {
    uuid id PK "ORG"
    uuid organization_id FK
    uuid granted_by_user_id FK
    uuid platform_user_id FK
    text reason
    timestamptz expires_at
    timestamptz revoked_at
    timestamptz created_at
  }
```

`audit_logs` and ledger tables are **append-only** in product rules.

---

## 7. Platform (separate identity)

```mermaid
erDiagram
  platform_roles ||--o{ platform_users : assigned
  platform_users ||--o{ platform_audit_logs : acts

  platform_roles {
    uuid id PK "PLATFORM"
    text name "super_admin|support|compliance"
  }

  platform_users {
    uuid id PK "PLATFORM"
    text email
    text password_hash
    uuid role_id FK
    boolean mfa_enabled
    timestamptz created_at
  }

  platform_audit_logs {
    uuid id PK "PLATFORM"
    uuid platform_user_id FK
    text action
    uuid organization_id "nullable target org"
    jsonb details
    inet ip
    timestamptz created_at
  }
```

Platform staff are **not** rows in `organization_members`. Break-glass access is `support_access_grants` on the tenant side plus `platform_audit_logs`.

---

## Tenant-owned tables (must have `organization_id`)

| Table | Notes |
| --- | --- |
| `organization_members` | Membership edge |
| `invitations` | Pending invites |
| `customers` | Soft-delete |
| `payment_methods` | No provider secrets |
| `transactions` | Money as `amount_minor` |
| `transaction_events` | Status history |
| `ledger_accounts` | Chart of accounts per org |
| `ledger_entries` | Immutable postings |
| `statement_imports` | Upload jobs |
| `statement_lines` | Parsed rows + fingerprint |
| `import_templates` | Column maps |
| `reconciliations` | Period runs |
| `reconciliation_items` | Expected/actual lines |
| `reconciliation_matches` | Links between items |
| `categories` | Optional labels |
| `audit_logs` | Company audit trail |
| `ai_conversations` | Read-only AI sessions |
| `ai_messages` | AI turns / tool results |
| `support_access_grants` | Owner-approved break-glass |

**Not tenant-owned:** `organizations` (root), `users` (identity), `platform_*`.

---

## Out of scope for MVP (named only)

`provider_integrations`, `webhook_events`, `settlements`, `documents`, `ai_insights` — Phase 2+. Do not add to Day 8 migrations unless the PRD changes.
