# cmd/api

The API process. Load configuration, construct dependencies, serve HTTP, and shut down cleanly.

Business rules live under `internal/`. This directory stays a wiring layer: routes, middleware, and `main`.
