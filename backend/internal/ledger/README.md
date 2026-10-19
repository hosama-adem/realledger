# ledger

Immutable double-entry books. Every financial event posts balanced debit and credit lines. A correction is a reversal linked to the original, plus a new entry.

Amounts are integer minor units. `105000` is 1,050.00 ETB. Posted lines are insert-only: the database rejects updates and deletes. This package is the only writer of ledger rows.
