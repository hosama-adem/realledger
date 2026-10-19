# reconciliation

Expected money versus actual money. A run takes a date range, one or more payment methods, and the statuses to include.

Pass 1 matches reference and amount. Pass 2 matches amount, a date window, and customer phone. Pass 3 offers fuzzy candidates for a person to review. Closing a period locks the result. Reopening is audited. A confirmed correction is posted through `ledger`.
