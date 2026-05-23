# Quickstart

This is the least confusing safe path for a fresh Shape mainnet Reth bring-up.

## Prerequisites

You need:
- a Linux host with fast SSD storage
- comfortable free disk headroom
- Docker and Docker Compose
- an Ethereum mainnet RPC URL
- an Ethereum mainnet beacon RPC URL
- a Shape Reth snapshot or transferred Reth datadir
- the runtime config artifacts:
  - `reth.toml`
  - `rollup.json`
  - `genesis-l2.json`

Recommended baseline:
- 8 vCPU or better
- 16 GB RAM minimum
- roughly 1 TB SSD/NVMe with headroom

## Fast path

1. Create the standard directories:
   ```bash
   ./scripts/bootstrap-shape-reth-layout.sh
   ```
2. Copy and edit the env file:
   ```bash
   cp examples/.env.example .env
   ```
3. Stage or transfer the snapshot into `/root/shape-mainnet-op-reth-staging`.
4. Read `docs/04-bootstrap-from-snapshot.md` and promote the datadir into the runtime path.
5. Start the stack:
   ```bash
   docker compose --env-file .env -f examples/docker-compose.yml up -d
   ```
6. Check health:
   ```bash
   ./scripts/check-shape-reth-health.sh
   ```
7. Repeat health sampling until block lag is shrinking or gone.

## Minimum safe mindset

Treat the machine as having separate lanes:
- **Reth lane**: the new canonical stack
- **legacy geth lane**: rollback only, if it still exists

Do not blur them.

## Do not do these things

- do not point `op-reth` at a geth datadir
- do not reuse default ports if another stack exists on the host
- do not call the node healthy just because containers started
- do not use `net_peerCount` as the main success metric on current Shape mainnet
- do not assume `eth_syncing=false` means the node is fully caught up
- do not delete a hard-to-replace transferred snapshot casually

## First checks after startup

Check these first and in this order:
1. local `eth_blockNumber`
2. public Shape `eth_blockNumber`
3. decimal lag between them
4. local `eth_syncing`
5. `optimism_syncStatus`
6. recent `op-node` logs
7. recent `op-reth` logs

If only one thing gets checked, check repeated decimal block samples over time.
