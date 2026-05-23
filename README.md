# Shape Mainnet Reth Runbook

Canonical setup and operator runbook for a self-hosted **Shape mainnet `op-reth` + `op-node`** stack.

This repo is the clean replacement for the older migration/journey notes. It pulls the best practical material forward, strips out the clutter, and centers the **golden Reth path**.

## What this repo is for

- first-time Shape mainnet Reth bring-up
- snapshot-first bootstrap
- clean runtime directory layout
- health checks based on real chain movement
- troubleshooting a live `op-reth` + `op-node` stack
- safe cutover to a clean Reth-only serving path

## What “healthy” means

A healthy node is not just “containers are up.”

A healthy node shows:
- local `eth_blockNumber` moving
- lag versus public Shape head shrinking or gone
- `op-node` deriving cleanly into `op-reth`
- block hash parity once caught up
- `eth_syncing=false` only after the node is actually caught up

## Start here

1. `docs/01-quickstart.md`
2. `docs/02-recommended-setup.md`
3. `docs/03-health-checks.md`
4. `examples/.env.example`
5. `examples/docker-compose.yml`

If you want the shortest path:
- run `scripts/bootstrap-shape-reth-layout.sh`
- copy `examples/.env.example` to `.env`
- review `docs/04-bootstrap-from-snapshot.md`
- start the compose stack
- verify with `scripts/check-shape-reth-health.sh`

## Canonical layout

```text
/root/shape-mainnet-op-reth-data
/root/shape-mainnet-op-reth-staging
/root/shape-mainnet-op-node-data
/root/.shape-mainnet-op-reth
```

Use `/root/Upload` only as optional support storage:
- download cache
- transfer landing zone
- backup copy of a known-good datadir

Do **not** make `/root/Upload` the default live mount for a fresh clean install.

## Runtime defaults in this repo

- `op-reth`: `us-docker.pkg.dev/oplabs-tools-artifacts/images/op-reth:v2.2.2`
- `op-node`: `us-docker.pkg.dev/oplabs-tools-artifacts/images/op-node:v1.18.0`
- `op-node` sync mode: `consensus-layer`
- `op-node` engine kind: `reth`
- non-default host ports to avoid collisions during migration

## Repo structure

- `docs/01-quickstart.md` — fastest safe operator path
- `docs/02-recommended-setup.md` — canonical runtime layout and service model
- `docs/03-health-checks.md` — how to verify real sync health
- `docs/04-bootstrap-from-snapshot.md` — snapshot-first bootstrap procedure
- `docs/05-troubleshooting.md` — likely failure modes and what to check first
- `docs/06-cutover-and-rollback.md` — migration discipline and rollback rules
- `docs/07-shape-specific-notes.md` — Shape realities that change operator behavior
- `examples/` — `.env` and Docker Compose templates
- `scripts/` — bootstrap and health-check helpers
- `skills/shape-network-mainnet-reth-setup/SKILL.md` — Hermes skill for this repo’s workflow

## Core operator rules

1. Treat Reth as the primary Shape mainnet path.
2. Keep runtime data, staging, and config in separate locations.
3. Use explicit config artifacts.
4. Report Shape block heights in decimal.
5. Judge success by execution progress, not peer count.
6. Keep the runtime clean, isolated, and explicitly Reth-only.
7. Prefer a snapshot-first bootstrap.
8. Do not casually swap versions without recording why.

## Source material

This repo was distilled from:
- `shape-mainnet-node-runbook`
- `shape-mainnet-op-reth-journey`

Those repos remain useful as historical context, but this one is the cleaner operator-facing canonical path.
