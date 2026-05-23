---
name: shape-network-mainnet-reth-setup
description: Use when setting up, operating, or troubleshooting the canonical Shape mainnet op-reth plus op-node stack from this repo. Treat op-geth as legacy rollback or archival context only.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [shape-network, shape-mainnet, op-reth, op-node, reth, docker, runbook]
    related_skills: [github-repo-management, hermes-agent]
---

# Shape Network Mainnet Reth Setup

## Overview

This skill is for the clean, canonical Shape mainnet Reth path:
- `op-reth` for execution
- `op-node` for derivation and rollup sync
- snapshot-first bootstrap
- explicit runtime config
- health checks based on real execution progress

This skill is repo-aligned and assumes the operator wants the Reth lane to be the main path.

## When to Use

Use it when:
- standing up a fresh Shape mainnet Reth node
- converting notes into a reusable Reth-first operator workflow
- validating a transferred or downloaded Reth datadir
- checking whether a live Shape Reth stack is healthy
- documenting cutover or rollback rules around a legacy geth lane

Do not use it when:
- the real task is generic Ethereum/geth recovery
- the job is primarily about reviving a sunset geth stack

## Core rules

1. Treat `op-reth` plus `op-node` as the primary Shape mainnet path.
2. Keep runtime data, staging data, and config files in separate locations.
3. Report Shape block heights in decimal.
4. Judge health by execution progress, not peer count.
5. Use explicit runtime files instead of over-trusting built-in defaults.
6. Keep any remaining geth lane as rollback or archival context only.
7. Preserve expensive-to-replace uploaded data until the runtime lane is proven.

## Canonical paths

Use these defaults unless there is a strong reason not to:
- `/root/shape-mainnet-op-reth-data`
- `/root/shape-mainnet-op-reth-staging`
- `/root/shape-mainnet-op-node-data`
- `/root/.shape-mainnet-op-reth`

Use `/root/Upload` only as support storage, not as the default live runtime mount.

## Shape-specific realities

- zero execution-layer peers may be expected on current Shape mainnet
- `net_peerCount = 0` is not the main failure signal
- public docs may lag runtime truth
- chain-spec handling and current fork state matter
- `safe_l2` and `finalized_l2` can lag `unsafe_l2` without implying failure

## Fast workflow

1. create the canonical directories
2. validate the staged datadir structurally
3. snapshot source config artifacts into the config dir
4. generate the JWT secret
5. start `op-reth` with explicit runtime files
6. start `op-node` with `--l2.enginekind=reth` and `--syncmode=consensus-layer`
7. sample local head, public head, lag, and sync status repeatedly
8. classify the node honestly: healthy, converging, stalled, or broken

## Red flags

- local execution head flat over repeated samples
- `unsafe_l2` movement without real execution-head movement
- repeated engine or forkchoice errors
- wrong datadir path, JWT path, or runtime config file path
- pressure to retire the rollback lane before Reth is actually proven

## Verification Checklist

- [ ] runtime, staging, and config paths are separated
- [ ] local head and public head are sampled in decimal
- [ ] lag trend is known
- [ ] `optimism_syncStatus` was checked
- [ ] fake movement was ruled out
- [ ] rollback posture remains intact until Reth is proven
