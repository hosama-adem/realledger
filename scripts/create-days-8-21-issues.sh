#!/usr/bin/env bash
# Creates Day 8–21 GitHub issues for RealLedger (M2). Idempotent by title prefix.
set -euo pipefail
REPO="${REPO:-hosama-adem/realledger}"
MILESTONE="M2 Foundation and Security"

exists() {
  local title="$1"
  gh issue list --repo "$REPO" --state all --search "in:title $title" --json title --jq ".[].title" \
    | grep -Fx "$title" >/dev/null 2>&1
}

create() {
  local title="$1"
  shift
  local labels="$1"
  shift
  if exists "$title"; then
    echo "skip: $title"
    return
  fi
  gh issue create --repo "$REPO" --title "$title" --milestone "$MILESTONE" --label "$labels" --body "$1"
  echo "created: $title"
}

create "feat: add migrations, sqlc and the first tables" "infra,feat,P0,medium,day-08" "$(cat <<'EOF'
## 🎯 Goal
Table changes are saved as numbered steps so every computer gets the same database.

## 🏷️ Class
Category: **infra** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 8 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Install goose and sqlc
- [ ] Add pgx connection pool
- [ ] Migration: organizations, users, organization_members
- [ ] Add sqlc config
- [ ] Make targets: migrate-up, migrate-down

## 🏁 Done when
- `make migrate-up` builds the tables and sqlc generates Go code.

## 🔗 Branch
`feat/day-08-add-migrations-sqlc-and`
EOF
)"

create "feat: project structure, errors and middleware" "setup,feat,P0,medium,day-09" "$(cat <<'EOF'
## 🎯 Goal
Every part of the app behaves the same way.

## 🏷️ Class
Category: **setup** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 9 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Create internal/ package layout
- [ ] Error type that returns problem+json
- [ ] Request ID middleware
- [ ] Panic recovery and request logging
- [ ] Input validation helper

## 🏁 Done when
- Every error has the same shape and each request has an ID in the logs.

## 🔗 Branch
`feat/day-09-project-structure-errors-and`
EOF
)"

create "chore: connect the OpenAPI contract to the code" "setup,chore,P1,medium,day-10" "$(cat <<'EOF'
## 🎯 Goal
The contract and the code can never disagree.

## 🏷️ Class
Category: **setup** · Type: **chore** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P1**
Day 10 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Install oapi-codegen
- [ ] Generate types from docs/realledger-openapi.yaml
- [ ] Serve the spec at /docs
- [ ] CI fails if generated code is out of date

## 🏁 Done when
- Types are generated and CI checks them.

## 🔗 Branch
`chore/day-10-connect-the-openapi-contract`
EOF
)"

create "feat: register — create user and company safely" "auth,feat,P0,hard,day-11" "$(cat <<'EOF'
## 🎯 Goal
The first thing a new user does must be all-or-nothing.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 11 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Hash passwords with argon2id
- [ ] POST /auth/register with validation
- [ ] One database transaction creates user, organization and Owner membership
- [ ] Unique email rule
- [ ] Write tests

## 🏁 Done when
- Registering creates all three records or none.

## 🔗 Branch
`feat/day-11-register-create-user-and`
EOF
)"

create "feat: login with short-lived access tokens" "auth,feat,P0,hard,day-12" "$(cat <<'EOF'
## 🎯 Goal
Safe sessions.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 12 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] POST /auth/login
- [ ] JWT access token (audience tenant, 15 minutes) with user id, organization id, role
- [ ] Same error for wrong email or wrong password
- [ ] Constant-time password check

## 🏁 Done when
- Valid login returns a token; wrong password returns a generic 401.

## 🔗 Branch
`feat/day-12-login-with-short-lived-access`
EOF
)"

create "feat: refresh tokens, logout and /me" "auth,feat,P0,hard,day-13" "$(cat <<'EOF'
## 🎯 Goal
Sessions that stay safe even if a token leaks.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 13 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Store refresh tokens hashed
- [ ] Rotate on every use (old one stops working)
- [ ] Reuse detection revokes the whole chain
- [ ] POST /auth/logout and GET /me

## 🏁 Done when
- Using an old refresh token fails and revokes the session.

## 🔗 Branch
`feat/day-13-refresh-tokens-logout-and`
EOF
)"

create "test: rate limits and auth test day" "security,test,P0,medium,day-14" "$(cat <<'EOF'
## 🎯 Goal
Stop password guessing and prove auth works.

## 🏷️ Class
Category: **security** · Type: **test** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 14 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Rate limit login and register by IP and email
- [ ] Slow down repeated failures (backoff)
- [ ] Table tests for every auth path
- [ ] Fix bugs found

## 🏁 Done when
- Brute-force attempts get 429 and all auth tests are green.

## 🔗 Branch
`test/day-14-rate-limits-and-auth`
EOF
)"

create "feat: email verification and password reset" "auth,feat,P1,medium,day-15" "$(cat <<'EOF'
## 🎯 Goal
Make sure accounts belong to real people.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P1**
Day 15 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] 6-digit codes with expiry
- [ ] One-time reset links
- [ ] Mailer interface with a console mailer for development
- [ ] SMS interface (stub for now)

## 🏁 Done when
- Verify and reset loops work in development.

## 🔗 Branch
`feat/day-15-email-verification-and-password`
EOF
)"

create "feat: roles and permission middleware" "security,feat,P0,medium,day-16" "$(cat <<'EOF'
## 🎯 Goal
Owner, Accountant and Viewer can only do what they are allowed.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 16 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Roles: OWNER, ACCOUNTANT, VIEWER
- [ ] Permission map from the PRD table
- [ ] Middleware per route
- [ ] Tests for every role

## 🏁 Done when
- The wrong role gets 403 on every protected route.

## 🔗 Branch
`feat/day-16-roles-and-permission-middleware`
EOF
)"

create "feat: invitations" "auth,feat,P0,medium,day-17" "$(cat <<'EOF'
## 🎯 Goal
Owners add their team.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 17 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] POST /members/invitations (Owner only)
- [ ] Invite token stored hashed with expiry
- [ ] Accept invitation creates user and membership
- [ ] Resend and revoke

## 🏁 Done when
- An invited accountant can accept and log in.

## 🔗 Branch
`feat/day-17-invitations`
EOF
)"

create "feat: member management and the last-owner rule" "auth,feat,P0,medium,day-18" "$(cat <<'EOF'
## 🎯 Goal
A company can never be left without an Owner.

## 🏷️ Class
Category: **auth** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~4h** · Priority: **P0**
Day 18 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] List members
- [ ] Change role
- [ ] Deactivate member
- [ ] Block removing or demoting the last Owner
- [ ] Tests

## 🏁 Done when
- The last Owner cannot be removed or demoted.

## 🔗 Branch
`feat/day-18-member-management-and-the`
EOF
)"

create "feat: company separation with Row-Level Security" "security,feat,P0,hard,day-19" "$(cat <<'EOF'
## 🎯 Goal
Company A must never be able to read company B's data.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🔴 Hard** · Time: **~6h** · Priority: **P0**
Day 19 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Set the organization id in the database session on every request
- [ ] Enable RLS and policies on all tenant tables
- [ ] App database user must not be a superuser or table owner
- [ ] CI check fails if a tenant table has no policy

## 🏁 Done when
- SQL run as company A cannot see company B rows.

## 🔗 Branch
`feat/day-19-company-separation-with-row-level`
EOF
)"

create "test: cross-tenant test suite" "security,test,P0,hard,day-20" "$(cat <<'EOF'
## 🎯 Goal
Permanent proof that separation works.

## 🏷️ Class
Category: **security** · Type: **test** · Difficulty: **🔴 Hard** · Time: **~5h** · Priority: **P0**
Day 20 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Helper creates two companies
- [ ] Call every route with the wrong token
- [ ] Expect 403 or 404 everywhere
- [ ] Run it in CI and require it to merge

## 🏁 Done when
- The suite is green and required for merging.

## 🔗 Branch
`test/day-20-cross-tenant-test-suite`
EOF
)"

create "feat: audit log (append-only)" "security,feat,P0,medium,day-21" "$(cat <<'EOF'
## 🎯 Goal
Every important action leaves a permanent trail.

## 🏷️ Class
Category: **security** · Type: **feat** · Difficulty: **🟡 Medium** · Time: **~5h** · Priority: **P0**
Day 21 · Milestone: M2 Foundation and Security

## ✅ Tasks
- [ ] Append-only audit_logs table
- [ ] Record who, what, when, resource, before/after summary, IP
- [ ] Cover auth, members, and other state-changing actions as they land
- [ ] Block UPDATE/DELETE at the database

## 🏁 Done when
- Critical actions write an audit row and the table cannot be edited.

## 🔗 Branch
`feat/day-21-audit-log-append-only`
EOF
)"

echo "ALL_ISSUES_DONE"
gh issue list --repo "$REPO" --milestone "$MILESTONE" --limit 20 --json number,title --jq '.[] | "#\(.number) \(.title)"'
