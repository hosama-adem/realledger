# RealLedger local tooling.
# Requires: Docker Desktop (or Docker Engine) with Compose v2+.
#
#   make up     Start PostgreSQL and wait until it accepts connections
#   make psql   Open a psql shell inside the db container
#   make down   Stop containers (named volume keeps data)

COMPOSE ?= docker compose
SERVICE ?= db
GO ?= go
API_DIR ?= backend

# Defaults match .env.example when .env is missing.
POSTGRES_USER ?= realledger
POSTGRES_DB ?= realledger

.PHONY: up down psql run test vet lint help

help:
	@echo "RealLedger make targets"
	@echo "  make up    - start PostgreSQL 16 (waits for healthy)"
	@echo "  make psql  - open a SQL shell in the db container"
	@echo "  make down  - stop containers (data stays in the volume)"
	@echo "  make run   - start the API on HTTP_ADDR (default :8080)"
	@echo "  make test  - run Go tests"
	@echo "  make vet   - run go vet"
	@echo "  make lint  - run golangci-lint (install separately)"
	@echo "Host port comes from POSTGRES_PORT in .env (default 5433)."

up:
	@if [ ! -f .env ]; then cp .env.example .env && echo "created .env from .env.example"; fi
	$(COMPOSE) up -d --wait
	@echo "PostgreSQL is ready. Run: make psql"

down:
	$(COMPOSE) down

psql:
	$(COMPOSE) exec $(SERVICE) psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

run:
	@if [ ! -f .env ]; then cp .env.example .env && echo "created .env from .env.example"; fi
	cd $(API_DIR) && $(GO) run ./cmd/api

test:
	cd $(API_DIR) && $(GO) test ./...

vet:
	cd $(API_DIR) && $(GO) vet ./...

lint:
	cd $(API_DIR) && golangci-lint run ./...
