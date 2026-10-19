# auth

Company identity. Register, log in, verify email or phone, reset a password, and issue a short-lived access token plus a rotating refresh token.

Passwords are hashed with argon2id. Staff accounts are a different identity and live in `platformadmin`.
