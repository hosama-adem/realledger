# RealLedger: Product Requirements Document (v2.0)

*Financial operations, immutable double-entry ledger and cross-channel reconciliation platform for Ethiopian businesses.*

- **Status:** MVP engineering blueprint (backend-first)
- **Date:** 18 October 2026
- **Positioning:** *Payment gateways move money. RealLedger explains it.*
- **Companion files:** `realledger-openapi.yaml` (API contract), `RealLedger-Roadmap-and-Issues.md` (90-day plan and GitHub issues)

> Naming note: this version uses the name **RealLedger**. Earlier drafts used "LedgerHub". Rename by search-and-replace if needed.

---

## 1. Overview

### 1.1 What it is
RealLedger is a multi-tenant web platform where a business records or imports its payments from Telebirr, Chapa, banks and cash, keeps an immutable ledger, reconciles **expected vs actual** money, and asks an AI assistant to explain differences.

### 1.2 What it is not
It is not a payment gateway. It does not move money, hold funds, or store bank or provider passwords, API secrets or credentials (MVP).

### 1.3 Problem
Businesses receive money through many channels. Records end up scattered across spreadsheets, provider dashboards and receipts. The result: duplicate or missing records, hours of manual matching, and no clear answer to "why is the amount short?"

### 1.4 Why now
- Digital payments are mainstream. Reports in 2026 put Telebirr at roughly 58-60M registered users and mobile money accounts in the 100M+ range.
- The National Bank's Digital Payments Strategy 2.0 pushes usage and merchant acceptance, so more merchants accept more channels.
- Gateways such as Chapa (10,000+ merchants) give merchants a dashboard for their own channel only. Nobody I found offers a neutral, cross-provider, reconciliation-first tool for Ethiopian businesses.

### 1.5 Three pillars
1. **True expected vs actual reconciliation.** *Expected* = what the business believes it should receive (sales, orders, invoices). *Actual* = what the provider or bank reports (statement files). CSV/Excel statement import is in the MVP. Live APIs come in Phase 2.
2. **Immutable double-entry ledger.** Money stored as integer minor units. Corrections are reversals plus new entries, never edits.
3. **Compliance by design** for Personal Data Protection Proclamation No. 1321/2024: consent, privacy notice, DPIA for AI, breach response, data minimization, and a recorded data-residency decision.

---

## 2. Competitive landscape

*Based on public company pages and press (Oct 2026). Features are as marketed, not tested. Pricing not found.*

| Category | Examples | Strengths | Weaknesses vs RealLedger |
|---|---|---|---|
| Spreadsheets and paper (real rival #1) | Excel, Google Sheets | Free, familiar | No audit trail, manual matching, no cross-channel view |
| Provider dashboards | Chapa, ArifPay, SantimPay, YaYa Wallet, Telebirr and bank portals | Authoritative for own channel | Own channel only; no expected vs actual |
| Global accounting | QuickBooks, Zoho Books, Sage 50, Xero, Odoo, TallyPrime | Full accounting | Not built around Ethiopian statements; heavier setup; localization gaps |
| Local ERP vendors | SyncEthio, Ashewa Smart ERP, ERP Solutions PLC, Marakisoft, iWork, Onrica | Local tax and workflow knowledge | Heavy, custom, ERP-centric |
| Simple bookkeeping apps | Mobile credit/debit apps | Very easy | No import, reconciliation or AI |
| Global ledger tools | Modern Treasury-style platforms | Strong engineering | Built for US/EU rails; no Ethiopian providers |

**Wedge:** (1) one neutral cross-channel view, (2) reconciliation-first with value in 30 minutes, (3) AI answers "why is it short?" with linked evidence, (4) complements gateways, ERPs and accountants.

**Threats and responses**
- Gateways add multi-provider reconciliation: stay neutral, partner.
- Local ERPs add a reconciliation module: integrate (export/API), use implementers as a sales channel.
- Global tools localize: move fast on Ethiopian statement templates; the parsed-format library is the moat.
- "Good enough" Excel: generous trial, Excel-like import, show hours saved.

**Target segment first:** online shops and marketplaces using two or more channels, then schools, clinics and retail chains.

---

## 3. Users, roles and tenancy

### 3.1 Company roles (customer app: `app.realledger.app`)

| Capability | Owner | Accountant | Viewer |
|---|---|---|---|
| Company profile, close organization | Yes | No | No |
| Invite/manage users, change roles | Yes | No | No |
| Payment methods (create/edit/deactivate) | Yes | View | View |
| Customers, transactions, imports, reversals | Yes | Yes | View |
| Run and close reconciliation | Yes | Yes | No |
| Reports and AI assistant | Yes | Yes | Read-only |
| Audit log | Full | Own actions | No |
| Submit verification details, grant support access | Yes | No | No |

- A company can have several Owners and must always keep at least one.
- There is no company-level "Admin". Its duties belong to the Owner. A delegated "Manager" role can be added later.

### 3.2 Platform Admin (RealLedger staff: `admin.realledger.app`)
- **Not a member of any organization.** Cannot log in to the customer app.
- Separate application, domain, API route group (`/admin-api`), `platform_users` table, token audience and signing keys.
- **Mandatory MFA**, short sessions, optional IP allowlist, rate limits. Staff accounts are created only by a Super Admin.
- Platform roles: **Super Admin** (staff and settings), **Support** (limited view/assist), **Compliance** (verification review).
- Can: search organizations, set verification status (Pending/Verified/Rejected with reason), suspend/reactivate, manage plans, limits and feature flags, view aggregate platform health and the platform audit log.
- **Cannot by default:** see customers, transactions, ledger or reconciliations; change any financial record; use the AI on company data.
- **Break-glass support:** an Owner grants time-limited (e.g., 24h), read-only access with a reason. It is logged, visible to the Owner, auto-expires and is revocable.

### 3.3 Multi-tenancy
- `organization_id` on every tenant-owned table, taken from the authenticated session, never from client input.
- Defense in depth: application scoping plus PostgreSQL Row-Level Security.
- CI runs a cross-tenant suite: Org A's token must get 403/404 on every Org B resource, and tenant tokens must never reach admin routes.

---

## 4. MVP scope

| In MVP | Later |
|---|---|
| Auth, organizations, company roles | Provider APIs and webhooks (Chapa, Telebirr, Kifiya, banks) |
| Customers, payment methods | Automatic settlement ingestion |
| Manual transactions and CSV/Excel import | Multi-currency FX revaluation |
| Double-entry ledger, reversals | Customer portal, auditor role |
| Reconciliation engine | Accounting-software export |
| Dashboard, reports, audit log | Forecasting, mobile app |
| Read-only AI assistant | Advanced platform analytics and billing |
| Minimal Platform Admin console | |

**Non-goals (MVP):** moving money, payment processing, credentials storage, government license verification, forecasting, autonomous AI decisions.

---

## 5. Functional requirements

### 5.1 Authentication and onboarding
- Email or phone plus password (argon2id), verification by email/SMS, password reset. MFA recommended for Owners.
- Flow: register, create organization, complete profile, invite team, add payment methods, ready.
- Organization: name, business type, country, email, phone, address; optional license number, TIN, registration number, description.
- Verification status (Not Submitted, Pending, Verified, Rejected) is set only by a Platform Admin. RealLedger does not claim government verification.

### 5.2 Customers
Name, phone (normalized to +251), email, reference (unique per organization), notes, created date. Soft-delete only. Duplicate warning on phone or reference.

### 5.3 Payment methods
Name, type (Mobile Money, Bank, Gateway, Cash, Other), description, status. Presets: Chapa, Telebirr, Kifiya, CBE Birr, bank transfer, cash. No credentials stored. A method can later link to an integration without changing identity. Managed by Owners.

### 5.4 Transactions
Fields: id, organization_id, customer, payment method, amount, currency, reference, transaction date, status (Pending, Received, Failed, Refunded, Cancelled), description, source (manual, import, api), created_by, created_at.

Rules:
- Money is BIGINT minor units plus currency (ETB: 105000 = 1,050.00). No floats anywhere. All math in the backend.
- Reference is unique per organization and payment method. Imports use a SHA-256 fingerprint (method + reference + amount + date) to flag duplicates.
- `Idempotency-Key` header required on all create, reverse and close operations.
- Status changes are recorded as events, not overwrites.

### 5.5 Ledger
- Every financial event posts balanced debit and credit entries (e.g., Dr Telebirr Clearing, Cr Sales Revenue). A refund posts reversing entries.
- Database triggers block UPDATE and DELETE on ledger tables. A constraint and tests enforce `SUM(debits) = SUM(credits)`.
- Corrections: **reversal** (linked to the original, with reason) plus a **new corrected entry**.

### 5.6 Statement import
Upload CSV/Excel, map columns (templates saved per provider), preview with errors and duplicates, confirm. Processing runs as a background job. Import history shows who, when, file name, rows accepted and rejected.

### 5.7 Reconciliation
- Inputs: date range, payment method(s), statuses.
- **Three-pass matching:** (1) exact reference and amount, (2) amount plus date window plus customer phone, (3) fuzzy candidates for human review.
- Output per method: expected, actual, difference, status (MATCHED or MISMATCH), plus unmatched items on each side, duplicates and timing differences.
- Users can link items, mark them explained with a note, and **close** the period (locks the result). Reopening is audited.
- Fixes go through the ledger and always need human confirmation. Export to CSV and PDF.

### 5.8 Dashboard and reports
Total received, transaction count, refunds, pending, failed, amounts by payment method, matched vs needs-review percentage, AI insights. Reports: daily and monthly summary, by method, by customer, refunds, pending aging, reconciliation history. ETB default, optional Ethiopian calendar display. Amharic UI planned for phase 1.5.

### 5.9 Audit log
Append-only: who, what, when, organization, resource, before/after summary, IP. Covers logins, user and role changes, payment methods, transactions, imports, reversals, reconciliation run/close/reopen, exports, AI requests, support-access grants. Platform actions go to a separate `platform_audit_logs`, and Owners can see admin actions that affected their organization.

---

## 6. AI requirements

**Principle:** the AI is a read-only analyst. It cannot write to the ledger.

| Feature | Behavior |
|---|---|
| Natural-language analytics | "How much did we receive through Telebirr this month?" The AI calls backend tools, the backend computes, the AI explains |
| **Reconciliation investigation** (flagship) | Analyzes refunds, pending, failed, duplicates, adjustments, timing, history. Output is split into **Known facts** (with linked transaction IDs) and **Possible explanations** (unconfirmed) |
| Categorization | Suggests a category; the user approves or rejects; nothing changes without approval |
| Anomaly detection | Statistics first (z-score/IQR per method for amount and daily volume); AI only explains. Wording is "unusual, please review", never "fraud" |
| Daily summary | Totals, refunds, top method, reconciliation status, items needing review |

**Read-only tools:** `get_transactions`, `get_transaction_summary`, `get_reconciliation`, `get_refunds`, `get_payment_methods`, `get_customer`, `get_anomalies`. All are organization-scoped and role-checked. Any proposed fix is a **draft** that a human must confirm before backend validation and ledger posting.

**Safety rules**
- Never changes balances, deletes, approves corrections, or claims access to external providers.
- All numbers come from tool results. If data is missing, say so.
- Validate tool arguments, cap result sizes, apply per-organization rate and cost limits.
- Treat descriptions and notes as untrusted data (prompt-injection defense).
- Mask personal data sent to the model where not needed. Log every request.
- Maintain a 100+ question evaluation set, run on every prompt or model change. Target above 90% correct.

---

## 7. Non-functional requirements

- **Security:** TLS, encryption at rest, secrets in a secret manager, rate limiting, brute-force protection, dependency scanning, OWASP ASVS review, tested backups.
- **Compliance:** consent and privacy notice, data-subject access and erasure workflow (balanced with financial retention), 72-hour breach plan, DPIA for AI, recorded hosting and cross-border decision.
- **Performance:** dashboard under 2s at 500k transactions per organization; reconciling 50k lines under 30s (async job).
- **Reliability:** 99.5% uptime target, daily backups, point-in-time recovery.
- **Usability:** light pages for low bandwidth, pagination, resumable imports, keyboard and screen-reader basics.

---

## 8. Data model (core tables)

Tenant: `organizations`, `users`, `organization_members`, `invitations`, `customers`, `payment_methods`, `transactions`, `transaction_events`, `ledger_accounts`, `ledger_entries`, `statement_imports`, `statement_lines`, `import_templates`, `reconciliations`, `reconciliation_items`, `reconciliation_matches`, `categories`, `audit_logs`, `ai_conversations`, `ai_messages`, `support_access_grants`.

Platform: `platform_users`, `platform_roles`, `platform_audit_logs`.

Later: `provider_integrations`, `webhook_events`, `settlements`, `documents`, `ai_insights`.

---

## 9. Technology stack (modular monolith)

| Layer | Choice |
|---|---|
| Backend | Go, Gin or chi, PostgreSQL 16, pgx |
| Queries and migrations | sqlc, goose (or Atlas) |
| Background jobs | River (Postgres-backed queue); Redis only if needed later |
| API contract | OpenAPI 3.1, generated TypeScript client |
| Customer app | Next.js, TypeScript, Tailwind, shadcn/ui, TanStack Query, TanStack Table, Recharts |
| Admin console | Separate Next.js app in the same monorepo, own deployment, domain and signing keys |
| Auth | argon2id; short-lived JWT plus rotating refresh tokens |
| AI | LLM API with tool calling inside `internal/ai`; provider swappable |
| Observability | OpenTelemetry, structured logs, Sentry |
| Infrastructure | Docker, GitHub Actions, Terraform |
| Hosting | Verify Ethiopian data-residency options; otherwise a nearby region with legal advice |
| Testing | Go table and property tests for money and ledger invariants, Playwright E2E, tenant-isolation suite |

Backend layout: `cmd/api`, `internal/{auth,organization,user,customer,paymentmethod,transaction,ledger,imports,reconciliation,audit,ai,platformadmin}`, `migrations`, `docs`, `tests`.

---

## 10. Success metrics
- Time to first reconciliation under 30 minutes after signup
- Weekly active accountants per organization
- Share of transactions reconciled automatically
- Self-reported hours saved per month
- Zero cross-tenant data leaks (hard requirement)
- AI evaluation score above 90%

---

## 11. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Manual entry fatigue | Import first, then APIs |
| Statement formats change | Template system, tests with real files |
| Wrong AI numbers | Tools compute, AI only narrates, evaluation suite |
| Data-protection exposure | Minimization, masking, residency decision, DPIA |
| Cross-tenant leak | RLS, automated tests, review gate |
| Excel is "good enough" | Win on time-to-first-reconciliation and mismatch explanations |
| Gateways or ERPs add reconciliation | Stay neutral, integrate, partner with accountants |
| Provider partnerships needed for APIs | Start with exports; approach providers after traction |

## 12. Open questions
1. Pricing: per organization, per user, or per transaction volume?
2. Which statement formats do pilot customers actually have?
3. Is VAT or tax reporting needed in the MVP?
4. Final hosting provider and LLM data-handling approach after legal review?
5. ETB only at launch, or USD from day one?
6. What do target customers use today for reconciliation and what do they pay?
7. Which ERP vendors and accountants would resell or integrate?

## 13. Glossary
- **Expected:** amounts the business should receive according to its own records.
- **Actual:** amounts reported by providers or banks.
- **Reversal:** a linked ledger entry that cancels an earlier entry without deleting it.
- **Minor units:** the smallest currency unit as an integer (105000 = 1,050.00 ETB).
- **Break-glass access:** temporary, logged, Owner-approved support access.
