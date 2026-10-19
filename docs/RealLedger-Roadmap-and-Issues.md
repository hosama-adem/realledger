# RealLedger: 90-Day Backend-First Roadmap and GitHub Issues

*Companion to `RealLedger-PRD-v2.md` and `realledger-openapi.yaml`.*

**Assumptions:** a small team (2-3 engineers plus a part-time designer), working backend-first so the API contract is stable before the frontend. Dates are relative (Day 1 = project start). Adjust if the team is smaller; the order matters more than the exact days.

---

## 1. Principles for the whole plan
1. **Money correctness before features.** Ledger and reconciliation get the most tests.
2. **Real data early.** Collect real Telebirr, Chapa and bank statement files in week 1 and build against them.
3. **Contract first.** `openapi.yaml` is locked at Day 50. The frontend uses a generated client.
4. **Security from day one.** Tenant isolation and admin separation are built in Milestone 2, not added later.
5. **Show users early.** A pilot user sees reconciliation by about Day 50 (API plus a simple UI or Postman demo).

---

## 2. Milestones

### Milestone 1: Validation, repo and design (Days 1-10)
| Day | Work | Output |
|---|---|---|
| 1-3 | Interview 15-20 accountants and owners; collect real statement exports (Telebirr, Chapa, CBE, other banks); ask what they use today and pay | Interview notes, sample files, pricing hypothesis |
| 3-4 | Create private monorepo `realledger-core` (apps: `api`, `web`, `admin`; packages: `ui`, `api-client`); Docker Compose with Postgres 16; goose migrations; sqlc; GitHub Actions (lint, test, build) | Green CI on an empty skeleton |
| 5-6 | Finalize schema (see PRD section 8) and migration plan | Reviewed ERD |
| 7-10 | Design in Figma: tokens, CSV column mapper, split-screen reconciliation workbench, AI investigator drawer, platform admin console | Clickable prototype |

**Exit check:** at least 10 interviews done, 3+ real statement formats collected, CI green.

### Milestone 2: Foundation, dual auth and tenant isolation (Days 11-22)
| Day | Work |
|---|---|
| 11-14 | Tenant auth (argon2id, short-lived JWT, rotating refresh tokens), registration with organization creation, invitations, company roles (Owner, Accountant, Viewer) |
| 15-18 | PostgreSQL Row-Level Security on all tenant tables; separate `platform_users` auth under `/admin-api` with different signing key and audience; mandatory MFA; support-access grants |
| 19-22 | Append-only `audit_logs` and `platform_audit_logs`; CI cross-tenant isolation suite (Org A token gets 403/404 on Org B; tenant tokens can never call admin routes) |

**Exit check:** isolation suite passes; one Owner can invite an Accountant; one platform admin can log in with MFA.

### Milestone 3: Financial core and double-entry ledger (Days 23-35)
| Day | Work |
|---|---|
| 23-25 | Customers (+251 normalization, soft-delete, duplicate warnings) and payment methods (presets, Owner only) |
| 26-30 | BIGINT double-entry ledger engine; `BEFORE UPDATE OR DELETE` triggers blocking changes; balanced debit/credit constraint; linked reversal plus corrected entry |
| 31-35 | `Idempotency-Key` middleware; property-based tests for money invariants (sum of entries is zero, reversals net to zero, no float anywhere) |

**Exit check:** a property test generates thousands of random transaction/reversal sequences and the ledger always balances.

### Milestone 4: Import, reconciliation engine and read-only AI (Days 36-50)
| Day | Work |
|---|---|
| 36-40 | River job queue; CSV/Excel upload, column mapping templates, SHA-256 fingerprint deduplication; import history |
| 41-45 | Three-pass matcher (exact reference and amount; amount plus date window plus phone; fuzzy candidates), manual linking, "explained" notes, close/reopen locking, CSV/PDF export |
| 46-50 | Anomaly detection (z-score/IQR); `internal/ai` with the seven read-only tools, PII masking, and the 100+ question evaluation set; **lock `openapi.yaml`** |

**Exit check:** a pilot accountant runs a real month of Telebirr data and gets a result; AI evaluation score is reported (target above 90%).

### Milestone 5: Customer app and reconciliation workbench (Days 51-75)
| Day | Work |
|---|---|
| 51-55 | Next.js app, generated TypeScript client and TanStack Query hooks, auth and onboarding flows |
| 56-62 | Transactions, customers, payment methods, reversal UI, optional Ethiopian calendar display |
| 63-70 | CSV mapper UI and split-screen reconciliation workbench with virtualized TanStack Table |
| 71-75 | Dashboard (Recharts), reports export, AI investigation drawer (known facts with linked transaction IDs vs possible explanations), daily summary |

**Exit check:** a new user goes from signup to first reconciliation in under 30 minutes in a usability test.

### Milestone 6: Admin console, hardening and private pilot (Days 76-90)
| Day | Work |
|---|---|
| 76-80 | Separate `admin` Next.js app: organization list, verification review, suspend, support-access view, platform audit log, metrics |
| 81-85 | Performance tests (dashboard under 2s at 500k transactions; reconciling 50k lines under 30s), backup and restore drill, Playwright E2E, security review (OWASP ASVS checklist), privacy notice and DPIA draft |
| 86-90 | Private pilot with 5-10 businesses; weekly feedback; measure time-to-first-reconciliation |

**Exit check:** zero open critical security findings; pilot users active weekly.

---

## 3. Definition of done (every issue)
- Code reviewed, tests added, CI green.
- OpenAPI updated when endpoints change.
- Tenant-isolation test added for any new tenant table or route.
- Audit log entry added for any state-changing action.
- No floating-point money anywhere (lint rule or review check).

---

## 4. Labels and workflow
- Labels: `security`, `ledger`, `ingestion`, `recon`, `ai`, `frontend`, `admin`, `infra`, `docs`, `bug`.
- Priorities: `P0` (blocks pilot), `P1`, `P2`.
- Milestones in GitHub: M1 to M6 above.
- Branching: trunk-based with short-lived branches and required reviews on `main`.

---

## 5. GitHub issues to create

### Issue 1 [security, P0, M2]: Tenant RLS and cross-tenant isolation suite
**Goal:** a tenant can never read or write another tenant's data.
**Tasks**
- Add `organization_id` to every tenant table; set it from the token, never from the body.
- Enable PostgreSQL RLS with policies using a per-request session setting.
- Build a CI suite that creates two organizations and calls every tenant route with the wrong token.

**Acceptance criteria**
- Every route returns 403 or 404 for cross-tenant IDs.
- A new tenant table without an RLS policy fails CI.

### Issue 2 [security, admin, P0, M2]: Separate platform admin identity
**Goal:** staff access is fully separated from customer access.
**Tasks**
- `platform_users`, `platform_roles` tables; separate JWT audience and signing key; mandatory MFA; short sessions; optional IP allowlist.
- Routes live under `/admin-api` and a different deployment/domain.

**Acceptance criteria**
- A tenant token is rejected by every admin route and vice versa.
- Staff accounts can only be created by a Super Admin.

### Issue 3 [ledger, P0, M3]: Immutable BIGINT double-entry engine
**Tasks**
- `ledger_accounts`, `ledger_entries`; triggers blocking UPDATE and DELETE; constraint that each posting balances.
- Reversal entries linked to the original, with a required reason, plus an optional corrected entry.

**Acceptance criteria**
- Attempting UPDATE or DELETE on ledger tables fails at the database.
- Property tests prove: sum of debits equals sum of credits, and a reversal nets the original to zero.

### Issue 4 [ledger, P1, M3]: Idempotency middleware
**Tasks:** store `Idempotency-Key` with request hash and response; return the stored response on repeat; reject the same key with a different body.
**Acceptance criteria:** double-clicking "Save" creates one transaction; conflicting reuse returns 409.

### Issue 5 [ingestion, P0, M4]: CSV/Excel statement import with fingerprint deduplication
**Tasks**
- Upload, column mapping, saved templates per provider, preview with errors and duplicates, commit via River worker.
- Fingerprint = SHA-256 of payment method + reference + amount + date.

**Acceptance criteria**
- Re-uploading the same file adds zero rows.
- Bad rows are listed with row numbers; good rows still import.
- Real Telebirr, Chapa and one bank format are covered by tests.

### Issue 6 [recon, P0, M4]: Three-pass reconciliation engine and period locking
**Tasks**
- Pass 1 exact reference and amount; pass 2 amount plus date window plus customer phone; pass 3 fuzzy candidates.
- Manual link, explained note, close and reopen (reason required), exports.

**Acceptance criteria**
- Result per payment method shows expected, actual, difference and MATCHED or MISMATCH.
- A closed period rejects new links until reopened (audited).
- 50k lines reconcile in under 30 seconds.

### Issue 7 [ai, P0, M4]: Read-only AI investigator and evaluation suite
**Tasks**
- Implement tools: `get_transactions`, `get_transaction_summary`, `get_reconciliation`, `get_refunds`, `get_payment_methods`, `get_customer`, `get_anomalies`.
- Mask personal data; validate tool arguments; cap result sizes; per-organization rate and cost limits.
- Output schema separates known facts (with transaction IDs) from possible explanations.
- Build 100+ question test set with known answers.

**Acceptance criteria**
- The AI has no write tools. Any proposed fix is only a draft.
- Evaluation score above 90%; failures logged for review.
- A transaction description containing "ignore instructions" does not change behavior.

### Issue 8 [ai, P1, M4]: Anomaly detection
**Tasks:** z-score or IQR per payment method for amount and daily volume; store alerts; wording is "unusual, please review".
**Acceptance criteria:** a 50,000 ETB payment among 500-2,000 ETB payments raises an alert; no "fraud" wording anywhere.

### Issue 9 [security, P0, M2]: Audit logging
**Tasks:** append-only `audit_logs` and `platform_audit_logs`; middleware plus explicit events; Owners can see admin actions affecting their organization.
**Acceptance criteria:** every state-changing endpoint writes who, what, when, organization, resource, IP; no UPDATE or DELETE possible.

### Issue 10 [admin, P1, M2/M6]: Break-glass support access
**Tasks:** Owner grants read-only access for a limited time with a reason; auto-expiry; revoke anytime; visible in the Owner's audit view.
**Acceptance criteria:** support cannot see any tenant data without an active grant; every access is logged.

### Issue 11 [frontend, P0, M5]: Generated API client and auth flows
**Tasks:** generate TypeScript client and TanStack Query hooks from `openapi.yaml`; sign-up, login, refresh, onboarding.
**Acceptance criteria:** the client is regenerated in CI; type errors appear if the API changes.

### Issue 12 [frontend, P0, M5]: CSV mapper and split-screen reconciliation workbench
**Tasks:** mapper with preview, expected-vs-actual split view with virtualized tables, link/explain actions, close.
**Acceptance criteria:** 50k rows scroll smoothly; keyboard-friendly matching; users complete first reconciliation in under 30 minutes in testing.

### Issue 13 [frontend, ai, P1, M5]: AI investigation drawer
**Tasks:** "Investigate with AI" button; render known facts with clickable transaction links and a clearly labeled "possible explanations" section.
**Acceptance criteria:** possible explanations are visually distinct and labeled unconfirmed.

### Issue 14 [frontend, P1, M5]: Dashboard and reports
**Tasks:** totals, by-method chart, matched percentage, anomalies panel, daily summary, CSV/PDF export, optional Ethiopian calendar display.
**Acceptance criteria:** dashboard loads in under 2 seconds with 500k transactions.

### Issue 15 [admin, P1, M6]: Platform admin console
**Tasks:** organization search, verification review (Pending, Verified, Rejected with reason), suspend/reactivate, metrics, platform audit log.
**Acceptance criteria:** no screen shows tenant financial data; every action writes to `platform_audit_logs`.

### Issue 16 [infra, P1, M6]: Backups, monitoring, load tests
**Tasks:** daily backups with a tested restore, point-in-time recovery, OpenTelemetry, Sentry, load tests for dashboard and reconciliation.
**Acceptance criteria:** restore drill completed and documented; alerts fire on error spikes and failed jobs.

### Issue 17 [docs, P1, M6]: Compliance pack
**Tasks:** privacy notice and consent wording, DPIA for AI features, breach response plan (72 hours), data-residency and LLM data-handling decision record, data-subject request process.
**Acceptance criteria:** reviewed by a lawyer familiar with Proclamation No. 1321/2024 before the pilot.

---

## 6. Risks to watch during the 90 days

| Risk | Early warning | Response |
|---|---|---|
| Real statement formats are messier than expected | Import rejects over 5% of real rows | Add templates, tolerant parsing, collect more samples |
| Matching quality is poor | Auto-match rate under 70% on pilot data | Tune passes, add provider-specific rules |
| AI gives wrong figures | Evaluation score under 90% | Force all numbers through tools, tighten prompts, block free-form arithmetic |
| Scope creep | New features before M4 exit | Park in a "Phase 2" label |
| Hosting or LLM residency blocks launch | Legal advice delayed | Decide by Day 40; keep the LLM provider swappable |

## 7. After Day 90 (Phase 2 candidates, in order)
1. Chapa API and webhooks, then Telebirr, then bank integrations.
2. Accounting/ERP export and partner integrations.
3. Amharic UI.
4. Auditor role and external accountant access.
5. Billing and plan management in the admin console.
