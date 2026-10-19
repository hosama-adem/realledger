# 🛠️ RealLedger: Backend-Only Plan (one issue per day)

**Start: Sunday 18 October 2026 (Day 1). Backend ready for the pilot: Sunday 27 December 2026 (Day 71).**

Only backend work is here: Go, PostgreSQL, security, ledger, import, reconciliation, AI tools, admin API, deployment. The frontend plan is separate.

## 📌 How to use this file (copy and paste)
1. Each day below has a ready **GitHub issue**: a title line and a body in a box.
2. On GitHub: **Issues → New issue** → paste the title → paste the body → add the labels shown → pick the milestone.
3. Or create **all 71 issues in one command** with `create-backend-issues.sh` (run it inside your repo after `gh auth login`).
4. Work on one issue per day, on its own branch, one pull request, write `Closes #NUMBER`.

## 🧭 Legend
| Mark | Meaning |
|---|---|
| 🟢 Easy | Simple, mostly setup |
| 🟡 Medium | Needs focus |
| 🔴 Hard | Careful thinking and tests, the risky parts |
| P0 / P1 / P2 | Must / Should / Nice |
| Time | Rough hours for one person |

If you work part-time, double the dates but keep the order. If a hard day takes two days, that is normal. Move the rest forward.

## 🏁 Milestones
| Milestone | Days | Dates | You will have |
|---|---|---|---|
| M1 Setup | 1-7 | 18 Oct to 24 Oct | Repo, Docker, Go server, CI, real statement files |
| M2 Foundation and Security | 8-23 | 25 Oct to 09 Nov | Login, roles, invites, company separation, audit log, admin identity |
| M3 Ledger Core | 24-37 | 10 Nov to 23 Nov | Customers, payment methods, safe double-entry ledger, transactions |
| M4 Import and Reconcile | 38-55 | 24 Nov to 11 Dec | Statement import, 3-pass reconciliation, drift, integrity, anomalies |
| M5 AI and Reports | 56-62 | 12 Dec to 18 Dec | Read-only AI investigator, evaluation, dashboard API, locked contract |
| M6 Hardening and Launch-ready | 63-71 | 19 Dec to 27 Dec | Admin API, support access, speed, backups, security, deploy |

## 📅 All days at a glance

| Day | Date | Category | Difficulty | Task |
|---|---|---|---|---|
| 1 | Sun 18 Oct | setup | 🟢 Easy | Create the private repository and put the docs inside |
| 2 | Mon 19 Oct | infra | 🟢 Easy | Run PostgreSQL locally with Docker |
| 3 | Tue 20 Oct | setup | 🟢 Easy | Create the Go server with a health check |
| 4 | Wed 21 Oct | infra | 🟢 Easy | Turn on automatic checks (CI) |
| 5 | Thu 22 Oct | research | 🟡 Medium | Collect real statement files and write format notes |
| 6 | Fri 23 Oct | docs | 🟡 Medium | Design the database (ERD) and naming rules |
| 7 | Sat 24 Oct | docs | 🟢 Easy | Week 1 review and GitHub setup (rest day) |
| 8 | Sun 25 Oct | infra | 🟡 Medium | Add migrations, sqlc and the first tables |
| 9 | Mon 26 Oct | setup | 🟡 Medium | Project structure, errors and middleware |
| 10 | Tue 27 Oct | setup | 🟡 Medium | Connect the OpenAPI contract to the code |
| 11 | Wed 28 Oct | auth | 🔴 Hard | Register: create user and company safely |
| 12 | Thu 29 Oct | auth | 🔴 Hard | Login with short-lived access tokens |
| 13 | Fri 30 Oct | auth | 🔴 Hard | Refresh tokens, logout and /me |
| 14 | Sat 31 Oct | security | 🟡 Medium | Rate limits and auth test day |
| 15 | Sun 01 Nov | auth | 🟡 Medium | Email verification and password reset |
| 16 | Mon 02 Nov | security | 🟡 Medium | Roles and permission middleware |
| 17 | Tue 03 Nov | auth | 🟡 Medium | Invitations |
| 18 | Wed 04 Nov | auth | 🟡 Medium | Member management and the last-owner rule |
| 19 | Thu 05 Nov | security | 🔴 Hard | Company separation with Row-Level Security |
| 20 | Fri 06 Nov | security | 🔴 Hard | Cross-tenant test suite |
| 21 | Sat 07 Nov | security | 🟡 Medium | Audit log (append-only) |
| 22 | Sun 08 Nov | admin | 🔴 Hard | Platform admin identity and MFA |
| 23 | Mon 09 Nov | admin | 🟡 Medium | Admin separation tests and platform audit log |
| 24 | Tue 10 Nov | ledger | 🟢 Easy | Customers API |
| 25 | Wed 11 Nov | ledger | 🟡 Medium | Customer search, phone clean-up and duplicates |
| 26 | Thu 12 Nov | ledger | 🟡 Medium | Payment methods API |
| 27 | Fri 13 Nov | ledger | 🔴 Hard | Ledger tables and constraints |
| 28 | Sat 14 Nov | ledger | 🔴 Hard | Double-entry posting engine |
| 29 | Sun 15 Nov | ledger | 🔴 Hard | Make the ledger permanent (immutability) |
| 30 | Mon 16 Nov | ledger | 🔴 Hard | Reversals and corrected entries |
| 31 | Tue 17 Nov | ledger | 🟡 Medium | Create and get transactions |
| 32 | Wed 18 Nov | ledger | 🟡 Medium | List transactions: filters, paging, indexes |
| 33 | Thu 19 Nov | ledger | 🟡 Medium | Safe retries (idempotency) |
| 34 | Fri 20 Nov | ledger | 🟡 Medium | Status changes as events |
| 35 | Sat 21 Nov | ledger | 🔴 Hard | Property tests: the ledger always balances |
| 36 | Sun 22 Nov | ledger | 🟡 Medium | Ledger read APIs: balances, entries, trial balance |
| 37 | Mon 23 Nov | docs | 🟢 Easy | Seed demo workspace and M3 review |
| 38 | Tue 24 Nov | ingestion | 🟡 Medium | File storage and upload endpoint |
| 39 | Wed 25 Nov | ingestion | 🔴 Hard | Parse CSV and Excel safely |
| 40 | Thu 26 Nov | ingestion | 🔴 Hard | Column mapping and templates |
| 41 | Fri 27 Nov | ingestion | 🔴 Hard | Import preview with errors and duplicates |
| 42 | Sat 28 Nov | ingestion | 🔴 Hard | Background jobs with River and import commit |
| 43 | Sun 29 Nov | ingestion | 🟡 Medium | Duplicate fingerprint and import history |
| 44 | Mon 30 Nov | ingestion | 🟡 Medium | Real-file tests for each provider |
| 45 | Tue 01 Dec | recon | 🟡 Medium | Reconciliation tables and run endpoint |
| 46 | Wed 02 Dec | recon | 🔴 Hard | Pass 1: exact match |
| 47 | Thu 03 Dec | recon | 🔴 Hard | Pass 2: amount, date window and phone |
| 48 | Fri 04 Dec | recon | 🔴 Hard | Pass 3: fuzzy suggestions |
| 49 | Sat 05 Dec | recon | 🟡 Medium | Link, explain and list results |
| 50 | Sun 06 Dec | recon | 🟡 Medium | Close and reopen (locking) |
| 51 | Mon 07 Dec | recon | 🟡 Medium | Export CSV and PDF |
| 52 | Tue 08 Dec | recon | 🔴 Hard | Drift Monitor and alerts |
| 53 | Wed 09 Dec | security | 🔴 Hard | Integrity hash chain and verify |
| 54 | Thu 10 Dec | ai | 🟡 Medium | Unusual activity detection |
| 55 | Fri 11 Dec | perf | 🔴 Hard | Reconcile 50,000 lines fast |
| 56 | Sat 12 Dec | ai | 🔴 Hard | AI tools layer (seven read-only tools) |
| 57 | Sun 13 Dec | ai | 🔴 Hard | Investigate endpoint: facts vs possible explanations |
| 58 | Mon 14 Dec | ai | 🔴 Hard | AI safety: masking, injection tests and limits |
| 59 | Tue 15 Dec | ai | 🔴 Hard | AI evaluation set (100 questions) |
| 60 | Wed 16 Dec | ai | 🟡 Medium | Category suggestions and daily summary |
| 61 | Thu 17 Dec | recon | 🟡 Medium | Dashboard and reports endpoints |
| 62 | Fri 18 Dec | docs | 🟡 Medium | Lock OpenAPI v2 and add contract tests |
| 63 | Sat 19 Dec | admin | 🟡 Medium | Admin API: organizations, verification, suspend, metrics |
| 64 | Sun 20 Dec | security | 🔴 Hard | Support access (break-glass) |
| 65 | Mon 21 Dec | perf | 🟡 Medium | Load tests and query tuning |
| 66 | Tue 22 Dec | infra | 🟡 Medium | Backups, restore drill and runbook |
| 67 | Wed 23 Dec | infra | 🟡 Medium | Observability |
| 68 | Thu 24 Dec | security | 🔴 Hard | Security review (ASVS checklist) |
| 69 | Fri 25 Dec | docs | 🟡 Medium | Compliance pack |
| 70 | Sat 26 Dec | infra | 🔴 Hard | Production image and staging deploy |
| 71 | Sun 27 Dec | docs | 🟢 Easy | Pilot-ready: final review and frontend handoff |

## 🔁 Daily habit (30 minutes)
Read yesterday's notes → pick today's issue → small commits → run tests → write 3 lines: done, stuck, next.

## 🚦 Stop signs
- Company-separation or ledger tests fail: stop and fix first.
- Real statement files do not import well: fix before building more.
- You skip a milestone checklist: do not move on.

---


# 🚩 M1 Setup

## Day 1 · Sunday 18 October 2026 · setup · 🟢 Easy

**Issue title (copy):**
```text
Day 1: Create the private repository and put the docs inside
```
**Labels (copy):** `setup, chore, P0, easy, day-01` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
One safe home for all code and documents.

## 🏷️ Class
Category: **setup** · Type: **chore** · Difficulty: **🟢 Easy** · Time: **~3h** · Priority: **P0**
Day 1 · Sun 18 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] Install Git, GitHub CLI, Go, Docker, VS Code
- [ ] Create GitHub account and turn on 2FA
- [ ] Create a PRIVATE repo named realledger
- [ ] Create folders backend/ and docs/, add README.md and .gitignore
- [ ] Copy the PRD, OpenAPI file and plans into docs/
- [ ] Push to main

## 🏁 Done when
- The repo is on GitHub with a README and the docs folder.

## 💬 Suggested commits
- `chore: initial project skeleton`
- `docs: add prd openapi and plans`

## 🔗 Branch
`chore/day-01-create-the-private-repository`
````

## Day 2 · Monday 19 October 2026 · infra · 🟢 Easy

**Issue title (copy):**
```text
Day 2: Run PostgreSQL locally with Docker
```
**Labels (copy):** `infra, chore, P0, easy, day-02` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Anyone can start the database with one command.

## 🏷️ Class
Category: **infra** · Type: **chore** · Difficulty: **🟢 Easy** · Time: **~3h** · Priority: **P0**
Day 2 · Mon 19 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] Create docker-compose.yml with postgres:16
- [ ] Create .env.example (DATABASE_URL, JWT secrets as placeholders)
- [ ] Create Makefile targets: up, down, psql
- [ ] Check you can connect

## 🏁 Done when
- `make up` starts the database and `make psql` connects.

## 💬 Suggested commits
- `chore: add docker compose for postgres`
- `chore: add env example and makefile`

## 🔗 Branch
`chore/day-02-run-postgresql-locally-with`
````

## Day 3 · Tuesday 20 October 2026 · setup · 🟢 Easy

**Issue title (copy):**
```text
Day 3: Create the Go server with a health check
```
**Labels (copy):** `setup, feat, P0, easy, day-03` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
A running server we can build on.

## 🏷️ Class
Category: **setup** · Type: **feat** · Difficulty: **🟢 Easy** · Time: **~4h** · Priority: **P0**
Day 3 · Tue 20 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] go mod init and add Gin
- [ ] Load settings from environment variables
- [ ] Add structured logging (slog)
- [ ] Add /health and /ready (ready checks the database)
- [ ] Add graceful shutdown

## 🏁 Done when
- `curl localhost:8080/health` returns ok and /ready checks the database.

## 💬 Suggested commits
- `feat: add gin server skeleton`
- `feat: add config and logging`
- `feat: add health and ready endpoints`

## 🔗 Branch
`feat/day-03-create-the-go-server`
````

## Day 4 · Wednesday 21 October 2026 · infra · 🟢 Easy

**Issue title (copy):**
```text
Day 4: Turn on automatic checks (CI)
```
**Labels (copy):** `infra, chore, P0, easy, day-04` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Every change is tested automatically so mistakes are caught early.

## 🏷️ Class
Category: **infra** · Type: **chore** · Difficulty: **🟢 Easy** · Time: **~3h** · Priority: **P0**
Day 4 · Wed 21 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] GitHub Actions: go vet, go test, golangci-lint
- [ ] Enable Dependabot
- [ ] Add gitleaks secret scan
- [ ] Protect main (if your GitHub plan allows)

## 🏁 Done when
- A pull request shows green checks.

## 💬 Suggested commits
- `chore: add github actions ci`
- `chore: add dependabot and gitleaks`

## 🔗 Branch
`chore/day-04-turn-on-automatic-checks`
````

## Day 5 · Thursday 22 October 2026 · research · 🟡 Medium

**Issue title (copy):**
```text
Day 5: Collect real statement files and write format notes
```
**Labels (copy):** `research, docs, P0, medium, day-05` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The import feature must fit real files, not guesses.

## 🏷️ Class
Category: **research** · Type: **docs** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 5 · Thu 22 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] Ask 8+ users for sample Telebirr, Chapa and bank statement files
- [ ] Remove or fake all personal data before saving
- [ ] List each file's columns, date format, amount format, encoding
- [ ] Note odd cases (refunds, fees, empty rows)
- [ ] Save anonymized samples in tests/fixtures/

## 🏁 Done when
- 3+ real formats are documented and fixtures are saved (no real personal data).

## 💬 Suggested commits
- `docs: add statement format notes`
- `test: add anonymized statement fixtures`

## 🔗 Branch
`docs/day-05-collect-real-statement-files`
````

## Day 6 · Friday 23 October 2026 · docs · 🟡 Medium

**Issue title (copy):**
```text
Day 6: Design the database (ERD) and naming rules
```
**Labels (copy):** `docs, docs, P0, medium, day-06` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Good tables now prevent painful changes later.

## 🏷️ Class
Category: **docs** · Type: **docs** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P0**
Day 6 · Fri 23 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] Draw all tables from PRD section 8 (Mermaid or image)
- [ ] Mark every per-company table with organization_id
- [ ] Decide: UUID ids, UTC timestamps, money as BIGINT minor units
- [ ] Write naming rules (snake_case, plural tables)

## 🏁 Done when
- ERD and rules are saved in docs/ and reviewed.

## 💬 Suggested commits
- `docs: add database erd`
- `docs: add database naming rules`

## 🔗 Branch
`docs/day-06-design-the-database-erd`
````

## Day 7 · Saturday 24 October 2026 · docs · 🟢 Easy

**Issue title (copy):**
```text
Day 7: Week 1 review and GitHub setup (rest day)
```
**Labels (copy):** `docs, docs, P1, easy, day-07` · **Milestone:** `M1 Setup`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Start week 2 organized.

## 🏷️ Class
Category: **docs** · Type: **docs** · Difficulty: **🟢 Easy** · Time: **~3h** · Priority: **P1**
Day 7 · Sat 24 Oct 2026 · Milestone: M1 Setup

## ✅ Tasks
- [ ] Create labels and milestones on GitHub
- [ ] Create issues for the next 2 weeks
- [ ] Write a 3-line retro: done, stuck, next
- [ ] Update README with run steps

## 🏁 Done when
- Board is ready and the retro is written.

## 💬 Suggested commits
- `docs: add week 1 retro`
- `docs: update readme run steps`

## 🔗 Branch
`docs/day-07-week-1-review-and`
````


# 🚩 M2 Foundation and Security

## Day 8 · Sunday 25 October 2026 · infra · 🟡 Medium

**Issue title (copy):**
```text
Day 8: Add migrations, sqlc and the first tables
```
**Labels (copy):** `infra, feat, P0, medium, day-08` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Table changes are saved as numbered steps so every computer gets the same database.

## 🏷️ Class
Category: **infra** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 8 · Sun 25 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Install goose and sqlc
- [ ] Add pgx connection pool
- [ ] Migration: organizations, users, organization_members
- [ ] Add sqlc config
- [ ] Make targets: migrate-up, migrate-down

## 🏁 Done when
- `make migrate-up` builds the tables and sqlc generates Go code.

## 💬 Suggested commits
- `chore: add goose and sqlc`
- `feat: add organizations users members tables`
- `feat: add pgx pool`

## 🔗 Branch
`feat/day-08-add-migrations-sqlc-and`
````

## Day 9 · Monday 26 October 2026 · setup · 🟡 Medium

**Issue title (copy):**
```text
Day 9: Project structure, errors and middleware
```
**Labels (copy):** `setup, feat, P0, medium, day-09` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Every part of the app behaves the same way.

## 🏷️ Class
Category: **setup** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 9 · Mon 26 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Create internal/ package layout
- [ ] Error type that returns problem+json
- [ ] Request ID middleware
- [ ] Panic recovery and request logging
- [ ] Input validation helper

## 🏁 Done when
- Every error has the same shape and each request has an ID in the logs.

## 💬 Suggested commits
- `feat: add problem json errors`
- `feat: add request id and logging middleware`
- `feat: add validation helper`

## 🔗 Branch
`feat/day-09-project-structure-errors-and`
````

## Day 10 · Tuesday 27 October 2026 · setup · 🟡 Medium

**Issue title (copy):**
```text
Day 10: Connect the OpenAPI contract to the code
```
**Labels (copy):** `setup, chore, P1, medium, day-10` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The contract and the code can never disagree.

## 🏷️ Class
Category: **setup** · Type: **chore** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 10 · Tue 27 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Install oapi-codegen
- [ ] Generate types from docs/realledger-openapi.yaml
- [ ] Serve the spec at /docs
- [ ] CI fails if generated code is out of date

## 🏁 Done when
- Types are generated and CI checks them.

## 💬 Suggested commits
- `chore: add oapi-codegen`
- `ci: check generated code is up to date`

## 🔗 Branch
`chore/day-10-connect-the-openapi-contract`
````

## Day 11 · Wednesday 28 October 2026 · auth · 🔴 Hard

**Issue title (copy):**
```text
Day 11: Register: create user and company safely
```
**Labels (copy):** `auth, feat, P0, hard, day-11` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The first thing a new user does must be all-or-nothing.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 11 · Wed 28 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Hash passwords with argon2id
- [ ] POST /auth/register with validation
- [ ] One database transaction creates user, organization and Owner membership
- [ ] Unique email rule
- [ ] Write tests

## 🏁 Done when
- Registering creates all three records or none.

## 💬 Suggested commits
- `feat: add password hashing`
- `feat: add register endpoint`
- `test: add register tests`

## 🔗 Branch
`feat/day-11-register-create-user-and`
````

## Day 12 · Thursday 29 October 2026 · auth · 🔴 Hard

**Issue title (copy):**
```text
Day 12: Login with short-lived access tokens
```
**Labels (copy):** `auth, feat, P0, hard, day-12` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Safe sessions.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 12 · Thu 29 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] POST /auth/login
- [ ] JWT access token (audience tenant, 15 minutes) with user id, organization id, role
- [ ] Same error for wrong email or wrong password
- [ ] Constant-time password check

## 🏁 Done when
- Valid login returns a token; wrong password returns a generic 401.

## 💬 Suggested commits
- `feat: add login endpoint`
- `feat: add jwt issue and verify`

## 🔗 Branch
`feat/day-12-login-with-short-lived-access`
````

## Day 13 · Friday 30 October 2026 · auth · 🔴 Hard

**Issue title (copy):**
```text
Day 13: Refresh tokens, logout and /me
```
**Labels (copy):** `auth, feat, P0, hard, day-13` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Sessions that stay safe even if a token leaks.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 13 · Fri 30 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Store refresh tokens hashed
- [ ] Rotate on every use (old one stops working)
- [ ] Reuse detection revokes the whole chain
- [ ] POST /auth/logout and GET /me

## 🏁 Done when
- Using an old refresh token fails and revokes the session.

## 💬 Suggested commits
- `feat: add refresh token rotation`
- `feat: add logout and me`

## 🔗 Branch
`feat/day-13-refresh-tokens-logout-and`
````

## Day 14 · Saturday 31 October 2026 · security · 🟡 Medium

**Issue title (copy):**
```text
Day 14: Rate limits and auth test day
```
**Labels (copy):** `security, test, P0, medium, day-14` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Stop password guessing and prove auth works. (Saturday: also do your weekly review.)

## 🏷️ Class
Category: **security** · Type: **test** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 14 · Sat 31 Oct 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Rate limit login and register by IP and email
- [ ] Slow down repeated failures (backoff)
- [ ] Table tests for every auth path
- [ ] Fix bugs found

## 🏁 Done when
- Brute-force attempts get 429 and all auth tests are green.

## 💬 Suggested commits
- `feat: add auth rate limiting`
- `test: add auth integration tests`

## 🔗 Branch
`test/day-14-rate-limits-and-auth`
````

## Day 15 · Sunday 01 November 2026 · auth · 🟡 Medium

**Issue title (copy):**
```text
Day 15: Email verification and password reset
```
**Labels (copy):** `auth, feat, P1, medium, day-15` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Make sure accounts belong to real people.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 15 · Sun 01 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] 6-digit codes with expiry
- [ ] One-time reset links
- [ ] Mailer interface with a console mailer for development
- [ ] SMS interface (stub for now)

## 🏁 Done when
- Verify and reset loops work in development.

## 💬 Suggested commits
- `feat: add email verification`
- `feat: add password reset`
- `feat: add mailer interface`

## 🔗 Branch
`feat/day-15-email-verification-and-password`
````

## Day 16 · Monday 02 November 2026 · security · 🟡 Medium

**Issue title (copy):**
```text
Day 16: Roles and permission middleware
```
**Labels (copy):** `security, feat, P0, medium, day-16` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Owner, Accountant and Viewer can only do what they are allowed.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 16 · Mon 02 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Roles: OWNER, ACCOUNTANT, VIEWER
- [ ] Permission map from the PRD table
- [ ] Middleware per route
- [ ] Tests for every role

## 🏁 Done when
- The wrong role gets 403 on every protected route.

## 💬 Suggested commits
- `feat: add role permission middleware`
- `test: add role matrix tests`

## 🔗 Branch
`feat/day-16-roles-and-permission-middleware`
````

## Day 17 · Tuesday 03 November 2026 · auth · 🟡 Medium

**Issue title (copy):**
```text
Day 17: Invitations
```
**Labels (copy):** `auth, feat, P0, medium, day-17` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Owners add their team.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 17 · Tue 03 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] POST /members/invitations (Owner only)
- [ ] Invite token stored hashed with expiry
- [ ] Accept invitation creates user and membership
- [ ] Resend and revoke

## 🏁 Done when
- An invited accountant can accept and log in.

## 💬 Suggested commits
- `feat: add member invitations`
- `feat: add accept invitation`

## 🔗 Branch
`feat/day-17-invitations`
````

## Day 18 · Wednesday 04 November 2026 · auth · 🟡 Medium

**Issue title (copy):**
```text
Day 18: Member management and the last-owner rule
```
**Labels (copy):** `auth, feat, P0, medium, day-18` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
A company can never be left without an Owner.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P0**
Day 18 · Wed 04 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] List members
- [ ] Change role
- [ ] Deactivate member
- [ ] Block removing or demoting the last Owner
- [ ] Tests

## 🏁 Done when
- The last Owner cannot be removed or demoted.

## 💬 Suggested commits
- `feat: add member management`
- `test: add last owner rule`

## 🔗 Branch
`feat/day-18-member-management-and-the`
````

## Day 19 · Thursday 05 November 2026 · security · 🔴 Hard

**Issue title (copy):**
```text
Day 19: Company separation with Row-Level Security
```
**Labels (copy):** `security, feat, P0, hard, day-19` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Company A must never be able to read company B's data.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 19 · Thu 05 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Set the organization id in the database session on every request
- [ ] Enable RLS and policies on all tenant tables
- [ ] App database user must not be a superuser or table owner
- [ ] CI check fails if a tenant table has no policy

## 🏁 Done when
- SQL run as company A cannot see company B rows.

## 💬 Suggested commits
- `feat: add tenant context to db session`
- `feat: enable row level security`
- `test: fail ci when table lacks policy`

## 🔗 Branch
`feat/day-19-company-separation-with-row-level`
````

## Day 20 · Friday 06 November 2026 · security · 🔴 Hard

**Issue title (copy):**
```text
Day 20: Cross-tenant test suite
```
**Labels (copy):** `security, test, P0, hard, day-20` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Permanent proof that separation works.

## 🏷️ Class
Category: **security** · Type: **test** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 20 · Fri 06 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Helper creates two companies
- [ ] Call every route with the wrong token
- [ ] Expect 403 or 404 everywhere
- [ ] Run it in CI and require it to merge

## 🏁 Done when
- The suite is green and required for merging.

## 💬 Suggested commits
- `test: add cross-tenant isolation suite`
- `ci: require isolation suite`

## 🔗 Branch
`test/day-20-cross-tenant-test-suite`
````

## Day 21 · Saturday 07 November 2026 · security · 🟡 Medium

**Issue title (copy):**
```text
Day 21: Audit log (append-only)
```
**Labels (copy):** `security, feat, P0, medium, day-21` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Every important action is recorded: who, what, when.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 21 · Sat 07 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] audit_logs table
- [ ] Trigger that blocks UPDATE and DELETE
- [ ] Helper and middleware
- [ ] Log register, login, invite, role change

## 🏁 Done when
- Actions create rows and editing a row fails.

## 💬 Suggested commits
- `feat: add audit log table`
- `feat: add audit middleware`

## 🔗 Branch
`feat/day-21-audit-log-append-only`
````

## Day 22 · Sunday 08 November 2026 · admin · 🔴 Hard

**Issue title (copy):**
```text
Day 22: Platform admin identity and MFA
```
**Labels (copy):** `admin, feat, P0, hard, day-22` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Our staff use a separate door with stronger security.

## 🏷️ Class
Category: **admin** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 22 · Sun 08 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] platform_users table
- [ ] Separate JWT signing key and audience (platform)
- [ ] TOTP MFA
- [ ] Routes under /admin-api
- [ ] Command to create the first Super Admin (no public signup)

## 🏁 Done when
- Tenant tokens fail on admin routes and admin login needs MFA.

## 💬 Suggested commits
- `feat: add platform users`
- `feat: add admin totp mfa`
- `feat: add create super admin command`

## 🔗 Branch
`feat/day-22-platform-admin-identity-and`
````

## Day 23 · Monday 09 November 2026 · admin · 🟡 Medium

**Issue title (copy):**
```text
Day 23: Admin separation tests and platform audit log
```
**Labels (copy):** `admin, test, P0, medium, day-23` · **Milestone:** `M2 Foundation and Security`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Staff access is visible and fully separated. (End of M2: review the checklist.)

## 🏷️ Class
Category: **admin** · Type: **test** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P0**
Day 23 · Mon 09 Nov 2026 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Tests: each token type is rejected on the other side
- [ ] platform_audit_logs table
- [ ] Log every admin action
- [ ] M2 review

## 🏁 Done when
- Tests are green and the M2 checklist is ticked.

## 💬 Suggested commits
- `test: tokens cannot cross audiences`
- `feat: add platform audit log`

## 🔗 Branch
`test/day-23-admin-separation-tests-and`
````


# 🚩 M3 Ledger Core

## Day 24 · Tuesday 10 November 2026 · ledger · 🟢 Easy

**Issue title (copy):**
```text
Day 24: Customers API
```
**Labels (copy):** `ledger, feat, P1, easy, day-24` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Who paid you.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟢 Easy** · Time: **~4h** · Priority: **P1**
Day 24 · Tue 10 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Create, get, update, archive (soft delete)
- [ ] Reference unique per company
- [ ] Audit entries
- [ ] Tests

## 🏁 Done when
- Customer CRUD works with tests and audit entries.

## 💬 Suggested commits
- `feat: add customer endpoints`
- `test: add customer tests`

## 🔗 Branch
`feat/day-24-customers-api`
````

## Day 25 · Wednesday 11 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 25: Customer search, phone clean-up and duplicates
```
**Labels (copy):** `ledger, feat, P1, medium, day-25` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Find customers fast and avoid doubles.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 25 · Wed 11 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Search by name, phone, reference
- [ ] Clean phone numbers to +251 format
- [ ] Duplicate warning on phone or reference
- [ ] Pagination

## 🏁 Done when
- Searching works and duplicates are warned about.

## 💬 Suggested commits
- `feat: add customer search`
- `feat: normalize ethiopian phone numbers`

## 🔗 Branch
`feat/day-25-customer-search-phone-clean-up`
````

## Day 26 · Thursday 12 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 26: Payment methods API
```
**Labels (copy):** `ledger, feat, P1, medium, day-26` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Telebirr, Chapa, bank and cash are labels the business uses.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 26 · Thu 12 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Create, list, update, deactivate (Owner only to change)
- [ ] Presets for Chapa, Telebirr, Kifiya, CBE Birr, bank, cash
- [ ] Never accept or store credentials
- [ ] Tests

## 🏁 Done when
- Accountant gets 403 on create and no secret fields exist.

## 💬 Suggested commits
- `feat: add payment method endpoints`
- `feat: add payment method presets`

## 🔗 Branch
`feat/day-26-payment-methods-api`
````

## Day 27 · Friday 13 November 2026 · ledger · 🔴 Hard

**Issue title (copy):**
```text
Day 27: Ledger tables and constraints
```
**Labels (copy):** `ledger, feat, P0, hard, day-27` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The foundation of correct money.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 27 · Fri 13 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Tables: ledger_accounts, transactions, ledger_entries
- [ ] Amounts as BIGINT minor units plus currency
- [ ] CHECK constraints (amount greater than zero)
- [ ] Create a default chart of accounts when a company is created

## 🏁 Done when
- Tables exist with constraints and RLS policies.

## 💬 Suggested commits
- `feat: add ledger tables`
- `feat: add default chart of accounts`

## 🔗 Branch
`feat/day-27-ledger-tables-and-constraints`
````

## Day 28 · Saturday 14 November 2026 · ledger · 🔴 Hard

**Issue title (copy):**
```text
Day 28: Double-entry posting engine
```
**Labels (copy):** `ledger, feat, P0, hard, day-28` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Every payment posts two matching entries so numbers always add up.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 28 · Sat 14 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Posting function in one database transaction
- [ ] Debits must equal credits (reject otherwise)
- [ ] Support sale, refund, fee postings
- [ ] Unit tests

## 🏁 Done when
- Every posting is balanced.

## 💬 Suggested commits
- `feat: add double entry posting`
- `test: add posting tests`

## 🔗 Branch
`feat/day-28-double-entry-posting-engine`
````

## Day 29 · Sunday 15 November 2026 · ledger · 🔴 Hard

**Issue title (copy):**
```text
Day 29: Make the ledger permanent (immutability)
```
**Labels (copy):** `ledger, feat, P0, hard, day-29` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
History must never be edited.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 29 · Sun 15 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Triggers block UPDATE and DELETE on ledger tables
- [ ] Revoke those rights from the app user
- [ ] Tests that try to edit and expect failure

## 🏁 Done when
- Editing or deleting a ledger row fails in the database.

## 💬 Suggested commits
- `feat: block ledger updates and deletes`
- `test: ledger rows cannot change`

## 🔗 Branch
`feat/day-29-make-the-ledger-permanent`
````

## Day 30 · Monday 16 November 2026 · ledger · 🔴 Hard

**Issue title (copy):**
```text
Day 30: Reversals and corrected entries
```
**Labels (copy):** `ledger, feat, P0, hard, day-30` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Mistakes are fixed by adding a linked correction.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 30 · Mon 16 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] POST /transactions/{id}/reverse with required reason
- [ ] Reversal entries link to the original
- [ ] Optional corrected transaction in the same step
- [ ] A transaction can only be reversed once

## 🏁 Done when
- The original plus reversal nets to zero and the history stays visible.

## 💬 Suggested commits
- `feat: add reversal with reason`
- `feat: add corrected entry on reversal`

## 🔗 Branch
`feat/day-30-reversals-and-corrected-entries`
````

## Day 31 · Tuesday 17 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 31: Create and get transactions
```
**Labels (copy):** `ledger, feat, P0, medium, day-31` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Record payments.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 31 · Tue 17 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] POST /transactions and GET /transactions/{id}
- [ ] Unique reference per company and payment method
- [ ] Validation (amount, currency, status)
- [ ] Audit entries

## 🏁 Done when
- A payment is saved with its ledger entries and an audit row.

## 💬 Suggested commits
- `feat: add create transaction`
- `feat: add get transaction`

## 🔗 Branch
`feat/day-31-create-and-get-transactions`
````

## Day 32 · Wednesday 18 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 32: List transactions: filters, paging, indexes
```
**Labels (copy):** `ledger, feat, P1, medium, day-32` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Fast lists even with many rows.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 32 · Wed 18 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Filters: method, customer, status, dates, amount
- [ ] Page and page_size
- [ ] Indexes for common queries
- [ ] Export-friendly sorting

## 🏁 Done when
- Listing 100,000 rows is fast with filters.

## 💬 Suggested commits
- `feat: add transaction list filters`
- `perf: add transaction indexes`

## 🔗 Branch
`feat/day-32-list-transactions-filters-paging`
````

## Day 33 · Thursday 19 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 33: Safe retries (idempotency)
```
**Labels (copy):** `ledger, feat, P0, medium, day-33` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Never create duplicates by accident.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 33 · Thu 19 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Idempotency-Key header on create, reverse and close routes
- [ ] Store key, request hash and response
- [ ] Same key returns the saved response
- [ ] Same key with a different body returns 409

## 🏁 Done when
- Double-submitting creates exactly one transaction.

## 💬 Suggested commits
- `feat: add idempotency middleware`
- `test: add idempotency tests`

## 🔗 Branch
`feat/day-33-safe-retries-idempotency`
````

## Day 34 · Friday 20 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 34: Status changes as events
```
**Labels (copy):** `ledger, feat, P1, medium, day-34` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Pending to Received is recorded, not overwritten.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 34 · Fri 20 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] transaction_events table
- [ ] Allowed status moves only
- [ ] Each change writes an event and an audit row

## 🏁 Done when
- Status history is visible and invalid moves are rejected.

## 💬 Suggested commits
- `feat: add transaction events`
- `feat: validate status transitions`

## 🔗 Branch
`feat/day-34-status-changes-as-events`
````

## Day 35 · Saturday 21 November 2026 · ledger · 🔴 Hard

**Issue title (copy):**
```text
Day 35: Property tests: the ledger always balances
```
**Labels (copy):** `ledger, test, P0, hard, day-35` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Prove the ledger can never go wrong.

## 🏷️ Class
Category: **ledger** · Type: **test** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 35 · Sat 21 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Add a property-testing library
- [ ] Generate thousands of random payments, refunds, reversals
- [ ] Check: debits equal credits, reversals net to zero
- [ ] Lint rule against floating-point money

## 🏁 Done when
- Property tests pass on every CI run.

## 💬 Suggested commits
- `test: add ledger property tests`
- `chore: add no-float lint rule`

## 🔗 Branch
`test/day-35-property-tests-the-ledger`
````

## Day 36 · Sunday 22 November 2026 · ledger · 🟡 Medium

**Issue title (copy):**
```text
Day 36: Ledger read APIs: balances, entries, trial balance
```
**Labels (copy):** `ledger, feat, P1, medium, day-36` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Let people see the books.

## 🏷️ Class
Category: **ledger** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 36 · Sun 22 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] GET account balances
- [ ] GET ledger entries with paging
- [ ] Trial balance endpoint (total debits equal total credits)

## 🏁 Done when
- Trial balance is always zero difference in tests.

## 💬 Suggested commits
- `feat: add ledger read endpoints`
- `feat: add trial balance`

## 🔗 Branch
`feat/day-36-ledger-read-apis-balances`
````

## Day 37 · Monday 23 November 2026 · docs · 🟢 Easy

**Issue title (copy):**
```text
Day 37: Seed demo workspace and M3 review
```
**Labels (copy):** `docs, chore, P1, easy, day-37` · **Milestone:** `M3 Ledger Core`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
A realistic demo company for tests and the frontend.

## 🏷️ Class
Category: **docs** · Type: **chore** · Difficulty: **🟢 Easy** · Time: **~4h** · Priority: **P1**
Day 37 · Mon 23 Nov 2026 · Milestone: M3 Ledger Core

## ✅ Tasks
- [ ] Seed script: 1 company, users, customers, methods, 500 transactions, a few refunds
- [ ] make seed command
- [ ] Update OpenAPI if needed
- [ ] M3 review

## 🏁 Done when
- make seed builds a demo workspace and M3 checklist is ticked.

## 💬 Suggested commits
- `chore: add seed script`
- `docs: update openapi for ledger`

## 🔗 Branch
`chore/day-37-seed-demo-workspace-and`
````


# 🚩 M4 Import and Reconcile

## Day 38 · Tuesday 24 November 2026 · ingestion · 🟡 Medium

**Issue title (copy):**
```text
Day 38: File storage and upload endpoint
```
**Labels (copy):** `ingestion, feat, P0, medium, day-38` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Safely receive statement files.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 38 · Tue 24 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Storage interface (local disk in dev, S3-compatible later)
- [ ] POST /imports/preview upload (multipart)
- [ ] Size and type limits
- [ ] Store files outside the database

## 🏁 Done when
- A CSV uploads and is stored with a file id.

## 💬 Suggested commits
- `feat: add storage interface`
- `feat: add statement upload endpoint`

## 🔗 Branch
`feat/day-38-file-storage-and-upload`
````

## Day 39 · Wednesday 25 November 2026 · ingestion · 🔴 Hard

**Issue title (copy):**
```text
Day 39: Parse CSV and Excel safely
```
**Labels (copy):** `ingestion, feat, P0, hard, day-39` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Read real files without crashing.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 39 · Wed 25 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] CSV parser (encoding and delimiter detection)
- [ ] Excel parser (excelize)
- [ ] Row limits and clear errors
- [ ] Protect against spreadsheet formula text

## 🏁 Done when
- All fixtures parse into rows.

## 💬 Suggested commits
- `feat: add csv parser`
- `feat: add excel parser`

## 🔗 Branch
`feat/day-39-parse-csv-and-excel`
````

## Day 40 · Thursday 26 November 2026 · ingestion · 🔴 Hard

**Issue title (copy):**
```text
Day 40: Column mapping and templates
```
**Labels (copy):** `ingestion, feat, P0, hard, day-40` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Users map file columns to RealLedger fields once.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 40 · Thu 26 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Mapping model: date, amount, reference, phone, type
- [ ] import_templates table
- [ ] Auto-detect for known providers
- [ ] Save and reuse templates

## 🏁 Done when
- A saved template maps a fixture correctly.

## 💬 Suggested commits
- `feat: add column mapping`
- `feat: add import templates`

## 🔗 Branch
`feat/day-40-column-mapping-and-templates`
````

## Day 41 · Friday 27 November 2026 · ingestion · 🔴 Hard

**Issue title (copy):**
```text
Day 41: Import preview with errors and duplicates
```
**Labels (copy):** `ingestion, feat, P0, hard, day-41` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Show problems before anything is saved.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 41 · Fri 27 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Validate each row (amounts, dates, references)
- [ ] Mark duplicates
- [ ] Return counts and sample rows
- [ ] Preview expires after a time

## 🏁 Done when
- Preview shows valid, duplicate and error counts for real files.

## 💬 Suggested commits
- `feat: add import preview`
- `feat: add row validation`

## 🔗 Branch
`feat/day-41-import-preview-with-errors`
````

## Day 42 · Saturday 28 November 2026 · ingestion · 🔴 Hard

**Issue title (copy):**
```text
Day 42: Background jobs with River and import commit
```
**Labels (copy):** `ingestion, feat, P0, hard, day-42` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Big files must never freeze the app.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 42 · Sat 28 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Install River (jobs inside Postgres)
- [ ] POST /imports to confirm a preview
- [ ] Worker saves rows in batches
- [ ] Job status endpoint

## 🏁 Done when
- A 50,000-row file imports in the background with progress.

## 💬 Suggested commits
- `feat: add river job queue`
- `feat: add import commit worker`

## 🔗 Branch
`feat/day-42-background-jobs-with-river`
````

## Day 43 · Sunday 29 November 2026 · ingestion · 🟡 Medium

**Issue title (copy):**
```text
Day 43: Duplicate fingerprint and import history
```
**Labels (copy):** `ingestion, feat, P0, medium, day-43` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Re-uploading the same file adds nothing.

## 🏷️ Class
Category: **ingestion** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 43 · Sun 29 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Fingerprint = SHA-256 of method + reference + amount + date
- [ ] Unique constraint per company
- [ ] Import history endpoint with counts
- [ ] Reject duplicates cleanly

## 🏁 Done when
- Uploading the same file twice adds zero rows.

## 💬 Suggested commits
- `feat: add duplicate fingerprint`
- `feat: add import history`

## 🔗 Branch
`feat/day-43-duplicate-fingerprint-and-import`
````

## Day 44 · Monday 30 November 2026 · ingestion · 🟡 Medium

**Issue title (copy):**
```text
Day 44: Real-file tests for each provider
```
**Labels (copy):** `ingestion, test, P0, medium, day-44` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Make sure real formats work.

## 🏷️ Class
Category: **ingestion** · Type: **test** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 44 · Mon 30 Nov 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] One test per fixture (Telebirr, Chapa, bank)
- [ ] Check totals match the file
- [ ] Edge cases: refunds, empty rows, odd dates
- [ ] Fix parser bugs

## 🏁 Done when
- All provider fixtures pass end to end.

## 💬 Suggested commits
- `test: add provider fixture tests`
- `fix: handle odd date formats`

## 🔗 Branch
`test/day-44-real-file-tests-for-each`
````

## Day 45 · Tuesday 01 December 2026 · recon · 🟡 Medium

**Issue title (copy):**
```text
Day 45: Reconciliation tables and run endpoint
```
**Labels (copy):** `recon, feat, P0, medium, day-45` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Start of the core feature.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 45 · Tue 01 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Tables: reconciliations, reconciliation_items, reconciliation_matches
- [ ] POST /reconciliations (period, methods, statuses)
- [ ] Compute expected and actual totals per method
- [ ] Run as a background job for big periods

## 🏁 Done when
- A run returns expected, actual and difference per method.

## 💬 Suggested commits
- `feat: add reconciliation tables`
- `feat: add run reconciliation endpoint`

## 🔗 Branch
`feat/day-45-reconciliation-tables-and-run`
````

## Day 46 · Wednesday 02 December 2026 · recon · 🔴 Hard

**Issue title (copy):**
```text
Day 46: Pass 1: exact match
```
**Labels (copy):** `recon, feat, P0, hard, day-46` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Match the obvious ones first.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 46 · Wed 02 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Match on exact reference and amount
- [ ] Mark matched items
- [ ] Unit tests with fixtures

## 🏁 Done when
- Exact pairs are matched automatically.

## 💬 Suggested commits
- `feat: add exact match pass`
- `test: add exact match tests`

## 🔗 Branch
`feat/day-46-pass-1-exact-match`
````

## Day 47 · Thursday 03 December 2026 · recon · 🔴 Hard

**Issue title (copy):**
```text
Day 47: Pass 2: amount, date window and phone
```
**Labels (copy):** `recon, feat, P0, hard, day-47` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Catch near matches.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 47 · Thu 03 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Match on same amount within a date window
- [ ] Use customer phone as tie-breaker
- [ ] Never match one line twice
- [ ] Tests

## 🏁 Done when
- Timing differences are matched and ties are handled.

## 💬 Suggested commits
- `feat: add window match pass`
- `test: add window match tests`

## 🔗 Branch
`feat/day-47-pass-2-amount-date`
````

## Day 48 · Friday 04 December 2026 · recon · 🔴 Hard

**Issue title (copy):**
```text
Day 48: Pass 3: fuzzy suggestions
```
**Labels (copy):** `recon, feat, P1, hard, day-48` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Suggest matches for a human to confirm.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P1**
Day 48 · Fri 04 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Score candidates (amount, date, similar reference)
- [ ] Store as SUGGESTED with a score
- [ ] Never auto-confirm
- [ ] Tests

## 🏁 Done when
- Suggestions appear with scores and nothing is auto-confirmed.

## 💬 Suggested commits
- `feat: add fuzzy suggestions`
- `test: add suggestion tests`

## 🔗 Branch
`feat/day-48-pass-3-fuzzy-suggestions`
````

## Day 49 · Saturday 05 December 2026 · recon · 🟡 Medium

**Issue title (copy):**
```text
Day 49: Link, explain and list results
```
**Labels (copy):** `recon, feat, P0, medium, day-49` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Let people finish the job.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 49 · Sat 05 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] POST matches (manual link)
- [ ] Mark explained with a note
- [ ] List items by state with paging
- [ ] Audit entries

## 🏁 Done when
- A user can link, explain and list every item state.

## 💬 Suggested commits
- `feat: add manual match link`
- `feat: add explain item`
- `feat: add list reconciliation items`

## 🔗 Branch
`feat/day-49-link-explain-and-list`
````

## Day 50 · Sunday 06 December 2026 · recon · 🟡 Medium

**Issue title (copy):**
```text
Day 50: Close and reopen (locking)
```
**Labels (copy):** `recon, feat, P0, medium, day-50` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
A finished period stays finished.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 50 · Sun 06 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] POST close and reopen
- [ ] Closed periods reject new links
- [ ] Reopen requires a reason
- [ ] Audit entries

## 🏁 Done when
- A closed period cannot change until reopened.

## 💬 Suggested commits
- `feat: add close reconciliation`
- `feat: add reopen with reason`

## 🔗 Branch
`feat/day-50-close-and-reopen-locking`
````

## Day 51 · Monday 07 December 2026 · recon · 🟡 Medium

**Issue title (copy):**
```text
Day 51: Export CSV and PDF
```
**Labels (copy):** `recon, feat, P1, medium, day-51` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Share results with accountants.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 51 · Mon 07 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] CSV export
- [ ] PDF export (simple clean layout)
- [ ] Stream large files
- [ ] Audit entry for exports

## 🏁 Done when
- Both files download and match the screen data.

## 💬 Suggested commits
- `feat: add csv export`
- `feat: add pdf export`

## 🔗 Branch
`feat/day-51-export-csv-and-pdf`
````

## Day 52 · Tuesday 08 December 2026 · recon · 🔴 Hard

**Issue title (copy):**
```text
Day 52: Drift Monitor and alerts
```
**Labels (copy):** `recon, feat, P1, hard, day-52` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Show the gap between expected and actual the day it appears.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P1**
Day 52 · Tue 08 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Daily drift per payment method
- [ ] Drift endpoint for the last 7 to 30 days
- [ ] Threshold setting per company
- [ ] Alert job (email) when drift passes the threshold

## 🏁 Done when
- A seeded gap shows on the right day and triggers an alert.

## 💬 Suggested commits
- `feat: add daily drift calculation`
- `feat: add drift alerts`

## 🔗 Branch
`feat/day-52-drift-monitor-and-alerts`
````

## Day 53 · Wednesday 09 December 2026 · security · 🔴 Hard

**Issue title (copy):**
```text
Day 53: Integrity hash chain and verify
```
**Labels (copy):** `security, feat, P1, hard, day-53` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Prove history was never changed.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P1**
Day 53 · Wed 09 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Each audit and ledger event stores the hash of the previous event
- [ ] Verify endpoint walks the chain
- [ ] Report the first broken link
- [ ] Tests that tamper with a row

## 🏁 Done when
- Changing a row makes verification fail and points to it.

## 💬 Suggested commits
- `feat: add hash chain`
- `feat: add integrity verify endpoint`

## 🔗 Branch
`feat/day-53-integrity-hash-chain-and`
````

## Day 54 · Thursday 10 December 2026 · ai · 🟡 Medium

**Issue title (copy):**
```text
Day 54: Unusual activity detection
```
**Labels (copy):** `ai, feat, P1, medium, day-54` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Warn about strange payments (not proof of fraud).

## 🏷️ Class
Category: **ai** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 54 · Thu 10 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Amount outliers per method (z-score or IQR)
- [ ] Unusual daily volume
- [ ] Store alerts with kind and message
- [ ] Wording: unusual, please review

## 🏁 Done when
- A 50,000 ETB payment among 500 to 2,000 ETB payments raises an alert.

## 💬 Suggested commits
- `feat: add amount anomaly detection`
- `feat: add volume anomaly detection`

## 🔗 Branch
`feat/day-54-unusual-activity-detection`
````

## Day 55 · Friday 11 December 2026 · perf · 🔴 Hard

**Issue title (copy):**
```text
Day 55: Reconcile 50,000 lines fast
```
**Labels (copy):** `perf, perf, P0, hard, day-55` · **Milestone:** `M4 Import and Reconcile`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The engine must be fast on real data.

## 🏷️ Class
Category: **perf** · Type: **perf** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 55 · Fri 11 Dec 2026 · Milestone: M4 Import and Reconcile

## ✅ Tasks
- [ ] Generate a 50,000-line benchmark
- [ ] Profile slow queries
- [ ] Add indexes and batch work
- [ ] Target: under 30 seconds

## 🏁 Done when
- Benchmark passes under 30 seconds in CI or a local script.

## 💬 Suggested commits
- `perf: add reconciliation benchmark`
- `perf: add indexes and batching`

## 🔗 Branch
`perf/day-55-reconcile-50000-lines-fast`
````


# 🚩 M5 AI and Reports

## Day 56 · Saturday 12 December 2026 · ai · 🔴 Hard

**Issue title (copy):**
```text
Day 56: AI tools layer (seven read-only tools)
```
**Labels (copy):** `ai, feat, P0, hard, day-56` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The AI reads data only through safe backend tools.

## 🏷️ Class
Category: **ai** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 56 · Sat 12 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Tools: get_transactions, get_transaction_summary, get_reconciliation, get_refunds, get_payment_methods, get_customer, get_anomalies
- [ ] Each tool is scoped to the company and role
- [ ] Validate arguments, cap result size
- [ ] No write tools exist

## 🏁 Done when
- Every tool works and respects company separation.

## 💬 Suggested commits
- `feat: add ai tool registry`
- `feat: add read-only ai tools`

## 🔗 Branch
`feat/day-56-ai-tools-layer-seven`
````

## Day 57 · Sunday 13 December 2026 · ai · 🔴 Hard

**Issue title (copy):**
```text
Day 57: Investigate endpoint: facts vs possible explanations
```
**Labels (copy):** `ai, feat, P0, hard, day-57` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The flagship AI feature.

## 🏷️ Class
Category: **ai** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 57 · Sun 13 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] LLM client wrapper (provider can be swapped)
- [ ] POST /ai/investigate
- [ ] Output schema: known_facts with transaction ids, possible_explanations marked unconfirmed
- [ ] Every number comes from tools

## 🏁 Done when
- A mismatch gets a structured answer with facts and guesses separated.

## 💬 Suggested commits
- `feat: add llm client wrapper`
- `feat: add investigate endpoint`

## 🔗 Branch
`feat/day-57-investigate-endpoint-facts-vs`
````

## Day 58 · Monday 14 December 2026 · ai · 🔴 Hard

**Issue title (copy):**
```text
Day 58: AI safety: masking, injection tests and limits
```
**Labels (copy):** `ai, security, P0, hard, day-58` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The AI must be safe and affordable.

## 🏷️ Class
Category: **ai** · Type: **security** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 58 · Mon 14 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Mask personal data sent to the model
- [ ] Tests with malicious text in descriptions and notes
- [ ] Rate and cost limits per company
- [ ] Log every AI request in the audit log

## 🏁 Done when
- Injected text changes nothing and limits work.

## 💬 Suggested commits
- `feat: add ai data masking`
- `test: add prompt injection tests`
- `feat: add ai rate and cost limits`

## 🔗 Branch
`security/day-58-ai-safety-masking-injection`
````

## Day 59 · Tuesday 15 December 2026 · ai · 🔴 Hard

**Issue title (copy):**
```text
Day 59: AI evaluation set (100 questions)
```
**Labels (copy):** `ai, test, P0, hard, day-59` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Measure answer quality.

## 🏷️ Class
Category: **ai** · Type: **test** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 59 · Tue 15 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Write 100 questions with known answers on the demo workspace
- [ ] Build a runner and score report
- [ ] Fail the build below 90 percent
- [ ] Log wrong answers for review

## 🏁 Done when
- Score is above 90 percent and tracked on every prompt change.

## 💬 Suggested commits
- `test: add ai evaluation set`
- `ci: add ai evaluation runner`

## 🔗 Branch
`test/day-59-ai-evaluation-set-100`
````

## Day 60 · Wednesday 16 December 2026 · ai · 🟡 Medium

**Issue title (copy):**
```text
Day 60: Category suggestions and daily summary
```
**Labels (copy):** `ai, feat, P2, medium, day-60` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Save time sorting payments.

## 🏷️ Class
Category: **ai** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P2**
Day 60 · Wed 16 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Suggest categories (needs approve or reject)
- [ ] Nothing changes without approval
- [ ] GET /summaries/daily

## 🏁 Done when
- Suggestions wait for a human and the summary is correct.

## 💬 Suggested commits
- `feat: add category suggestions`
- `feat: add daily summary`

## 🔗 Branch
`feat/day-60-category-suggestions-and-daily`
````

## Day 61 · Thursday 17 December 2026 · recon · 🟡 Medium

**Issue title (copy):**
```text
Day 61: Dashboard and reports endpoints
```
**Labels (copy):** `recon, feat, P1, medium, day-61` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The numbers for the main screen and reports.

## 🏷️ Class
Category: **recon** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 61 · Thu 17 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Dashboard totals, by method, matched percentage, anomalies
- [ ] Report endpoints
- [ ] Cache safe parts if needed

## 🏁 Done when
- Dashboard responds under 2 seconds on a large demo dataset.

## 💬 Suggested commits
- `feat: add dashboard endpoint`
- `feat: add report endpoints`

## 🔗 Branch
`feat/day-61-dashboard-and-reports-endpoints`
````

## Day 62 · Friday 18 December 2026 · docs · 🟡 Medium

**Issue title (copy):**
```text
Day 62: Lock OpenAPI v2 and add contract tests
```
**Labels (copy):** `docs, docs, P0, medium, day-62` · **Milestone:** `M5 AI and Reports`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The frontend can now build safely.

## 🏷️ Class
Category: **docs** · Type: **docs** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P0**
Day 62 · Fri 18 Dec 2026 · Milestone: M5 AI and Reports

## ✅ Tasks
- [ ] Update docs/realledger-openapi.yaml to match the code
- [ ] Contract tests (responses match the spec)
- [ ] Tag the release v0.1.0
- [ ] Share the spec with the frontend

## 🏁 Done when
- Spec equals code, tests pass, v0.1.0 tagged.

## 💬 Suggested commits
- `docs: lock openapi v2`
- `test: add contract tests`
- `chore: tag v0.1.0`

## 🔗 Branch
`docs/day-62-lock-openapi-v2-and`
````


# 🚩 M6 Hardening and Launch-ready

## Day 63 · Saturday 19 December 2026 · admin · 🟡 Medium

**Issue title (copy):**
```text
Day 63: Admin API: organizations, verification, suspend, metrics
```
**Labels (copy):** `admin, feat, P0, medium, day-63` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Staff can run the platform without seeing money.

## 🏷️ Class
Category: **admin** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 63 · Sat 19 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] List and search organizations
- [ ] Set verification status with reason
- [ ] Suspend and reactivate
- [ ] Aggregate metrics only
- [ ] Every action in platform audit log

## 🏁 Done when
- No admin route returns company financial data.

## 💬 Suggested commits
- `feat: add admin organization endpoints`
- `feat: add verification review api`
- `feat: add platform metrics`

## 🔗 Branch
`feat/day-63-admin-api-organizations-verification`
````

## Day 64 · Sunday 20 December 2026 · security · 🔴 Hard

**Issue title (copy):**
```text
Day 64: Support access (break-glass)
```
**Labels (copy):** `security, feat, P1, hard, day-64` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Staff can help only when the Owner allows it.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P1**
Day 64 · Sun 20 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Owner grants read-only access for 1 to 72 hours with a reason
- [ ] Auto-expire and revoke
- [ ] Staff read endpoints require an active grant
- [ ] Visible in both audit logs

## 🏁 Done when
- Without a grant, support sees nothing.

## 💬 Suggested commits
- `feat: add support access grants`
- `test: support cannot read without grant`

## 🔗 Branch
`feat/day-64-support-access-break-glass`
````

## Day 65 · Monday 21 December 2026 · perf · 🟡 Medium

**Issue title (copy):**
```text
Day 65: Load tests and query tuning
```
**Labels (copy):** `perf, perf, P0, medium, day-65` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Be sure it stays fast.

## 🏷️ Class
Category: **perf** · Type: **perf** · Difficulty: **🟡 Medium** · Time: **~6h** · Priority: **P0**
Day 65 · Mon 21 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Load test with k6 or similar
- [ ] Check dashboard, transaction list, import, reconcile
- [ ] Fix slow queries (EXPLAIN)
- [ ] Record results

## 🏁 Done when
- Targets are met and results are documented.

## 💬 Suggested commits
- `perf: add load tests`
- `perf: tune slow queries`

## 🔗 Branch
`perf/day-65-load-tests-and-query`
````

## Day 66 · Tuesday 22 December 2026 · infra · 🟡 Medium

**Issue title (copy):**
```text
Day 66: Backups, restore drill and runbook
```
**Labels (copy):** `infra, chore, P0, medium, day-66` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
A backup you never tested is not a backup.

## 🏷️ Class
Category: **infra** · Type: **chore** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 66 · Tue 22 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Daily database backups
- [ ] Point-in-time recovery if available
- [ ] Do a real restore on a clean machine
- [ ] Write the runbook

## 🏁 Done when
- Restore is tested and documented.

## 💬 Suggested commits
- `chore: add backup job`
- `docs: add restore runbook`

## 🔗 Branch
`chore/day-66-backups-restore-drill-and`
````

## Day 67 · Wednesday 23 December 2026 · infra · 🟡 Medium

**Issue title (copy):**
```text
Day 67: Observability
```
**Labels (copy):** `infra, chore, P1, medium, day-67` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
See problems before customers do.

## 🏷️ Class
Category: **infra** · Type: **chore** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 67 · Wed 23 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] OpenTelemetry traces
- [ ] Sentry errors
- [ ] Readiness and metrics endpoints
- [ ] Alerts for error spikes and failed jobs

## 🏁 Done when
- A test error appears in Sentry and an alert fires.

## 💬 Suggested commits
- `chore: add opentelemetry`
- `chore: add sentry`

## 🔗 Branch
`chore/day-67-observability`
````

## Day 68 · Thursday 24 December 2026 · security · 🔴 Hard

**Issue title (copy):**
```text
Day 68: Security review (ASVS checklist)
```
**Labels (copy):** `security, chore, P0, hard, day-68` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Find holes before others do.

## 🏷️ Class
Category: **security** · Type: **chore** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 68 · Thu 24 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Walk the OWASP ASVS checklist
- [ ] Security headers, CORS, cookie settings
- [ ] Dependency and secret scans clean
- [ ] Fix critical findings

## 🏁 Done when
- No open critical findings.

## 💬 Suggested commits
- `chore: add security headers`
- `fix: address asvs findings`

## 🔗 Branch
`chore/day-68-security-review-asvs-checklist`
````

## Day 69 · Friday 25 December 2026 · docs · 🟡 Medium

**Issue title (copy):**
```text
Day 69: Compliance pack
```
**Labels (copy):** `docs, docs, P0, medium, day-69` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Meet data protection duties.

## 🏷️ Class
Category: **docs** · Type: **docs** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 69 · Fri 25 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Privacy notice and consent wording
- [ ] DPIA for the AI features
- [ ] Breach response plan (72 hours)
- [ ] Decide data location and AI data handling
- [ ] Ask a lawyer to review

## 🏁 Done when
- Documents exist and the lawyer review is booked.

## 💬 Suggested commits
- `docs: add privacy notice`
- `docs: add dpia`
- `docs: add breach response plan`

## 🔗 Branch
`docs/day-69-compliance-pack`
````

## Day 70 · Saturday 26 December 2026 · infra · 🔴 Hard

**Issue title (copy):**
```text
Day 70: Production image and staging deploy
```
**Labels (copy):** `infra, chore, P0, hard, day-70` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
Ship it somewhere real.

## 🏷️ Class
Category: **infra** · Type: **chore** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 70 · Sat 26 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Small production Dockerfile
- [ ] Deploy pipeline from GitHub Actions to staging
- [ ] Environment secrets in the host, not in git
- [ ] Run migrations safely on deploy

## 🏁 Done when
- Staging runs the latest main and /ready is green.

## 💬 Suggested commits
- `chore: add production dockerfile`
- `ci: add staging deploy`

## 🔗 Branch
`chore/day-70-production-image-and-staging`
````

## Day 71 · Sunday 27 December 2026 · docs · 🟢 Easy

**Issue title (copy):**
```text
Day 71: Pilot-ready: final review and frontend handoff
```
**Labels (copy):** `docs, chore, P0, easy, day-71` · **Milestone:** `M6 Hardening and Launch-ready`

**Issue body (copy everything in the box):**
````markdown
## 🎯 Goal
The backend is ready for real users.

## 🏷️ Class
Category: **docs** · Type: **chore** · Difficulty: **🟢 Easy** · Time: **~4h** · Priority: **P0**
Day 71 · Sun 27 Dec 2026 · Milestone: M6 Hardening and Launch-ready

## ✅ Tasks
- [ ] Run the full test suite and benchmarks
- [ ] Check the Day 1 to 70 checklist
- [ ] Update README and API docs
- [ ] Write the handoff note for the frontend

## 🏁 Done when
- Backend is tagged v1.0.0-pilot and documented.

## 💬 Suggested commits
- `docs: add handoff notes`
- `chore: tag v1.0.0-pilot`

## 🔗 Branch
`chore/day-71-pilot-ready-final-review-and`
````
