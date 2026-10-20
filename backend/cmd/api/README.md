# cmd/api

Process entrypoint for the RealLedger HTTP API.

```bash
# from repo root
make up
make run
```

| Route | Meaning |
| --- | --- |
| `GET /health` | Process is alive. No database check. |
| `GET /ready` | Process can reach PostgreSQL. |

Configuration comes from the environment (see root `.env.example`). Business rules stay under `internal/` domain packages — this directory only wires config, the DB pool, routes, and graceful shutdown.
