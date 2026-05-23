# Shape-Specific Notes

These points matter enough to change operator behavior.

## Reality notes

- Shape mainnet is OP Stack-based.
- `Jovian` and other fork details matter.
- Public docs can lag runtime truth.
- Current Shape execution-layer peer count may remain zero by design.
- Zero EL peers is not the main success signal.
- `safe_l2` and `finalized_l2` can trail `unsafe_l2` without meaning the stack is broken.

## Practical consequences

- use explicit runtime files instead of over-trusting built-in defaults
- prioritize execution-head movement over peer count
- compare against public Shape RPC repeatedly
- verify block height and hash parity after catch-up

## Reporting standard

When reporting node state:
- use decimal block numbers
- say whether head is rising, flat, or caught up
- include local head, public head, and lag
- distinguish healthy, converging, stalled, and broken
