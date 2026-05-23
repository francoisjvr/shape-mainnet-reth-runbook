# Recommended Setup

This is the canonical Shape mainnet `op-reth` + `op-node` setup this repo recommends.

## Directory layout

```bash
export RETH_RUNTIME_DIR=/root/shape-mainnet-op-reth-data
export RETH_STAGING_DIR=/root/shape-mainnet-op-reth-staging
export OP_NODE_RUNTIME_DIR=/root/shape-mainnet-op-node-data
export CONFIG_DIR=/root/.shape-mainnet-op-reth
```

Path meanings:
- `RETH_RUNTIME_DIR`: live Reth datadir
- `RETH_STAGING_DIR`: temporary snapshot extraction or transfer staging area
- `OP_NODE_RUNTIME_DIR`: persistent `op-node` state
- `CONFIG_DIR`: runtime config and JWT secret

## Runtime config files

Keep these in `CONFIG_DIR`:
- `reth.runtime.toml`
- `rollup.runtime.json`
- `genesis-l2.runtime.json`
- `jwt.hex`

Optionally preserve source artifacts separately:
- `reth.source.toml`
- `rollup.source.json`
- `genesis-l2.source.json`
- `known-peers.source.json`

Keep a clear split between source artifacts and runtime artifacts.

## Ports

This repo uses non-default ports on purpose:
- `18545` — `op-reth` HTTP RPC
- `18546` — `op-reth` WebSocket RPC
- `18551` — `op-reth` Engine/Auth RPC
- `31303` — `op-reth` P2P
- `19545` — `op-node` RPC
- `17300` — `op-node` metrics
- `19222` — `op-node` P2P TCP/UDP

These avoid collisions with default ports and keep the runtime layout explicit.

## Service model

### `op-reth`
Use:
- explicit `--config`
- explicit `--chain`
- isolated datadir
- explicit rollup sequencer and historical RPC flags
- `--disable-discovery`

### `op-node`
Use:
- `--l2.enginekind=reth`
- `--syncmode=consensus-layer`
- explicit rollup config
- shared JWT secret
- explicit Shape bootnodes when validated

## Version policy

Start with the currently validated images in this repo:
- `op-reth:v2.2.2`
- `op-node:v1.18.0`

If versions change:
- change them intentionally
- record why
- rerun health verification

## Safety posture

- if disk is tight, prefer moving a validated datadir into the runtime path over making a second full copy
- use `/root/Upload` only as support storage, not as the default live runtime mount
