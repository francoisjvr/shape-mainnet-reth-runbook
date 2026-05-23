# Cutover and Rollback

This repo is Reth-first, but cutover still needs discipline.

## Before cutover

Do not change the serving path or declare the node production-ready until all of these are true:
- local Shape head matches public Shape head
- latest local block hash matches public latest block hash
- `eth_chainId` is `360`
- `eth_syncing=false`
- `op-node` continues deriving cleanly
- no serious recent `op-reth` errors

## Cutover principles

- make one change at a time
- keep rollback simple
- preserve the old lane until the new lane is proven
- document port and endpoint changes clearly

## Rollback triggers

Rollback is justified if:
- execution head stalls for repeated samples
- the node falls behind and does not recover
- hash parity checks fail after expected convergence time
- engine or forkchoice errors keep repeating
- the new lane cannot serve the required workload safely

## Rollback posture

If a rollback lane still exists:
- do not mutate it casually during testing
- keep its ports and data paths distinct
- use it as a control sample, not as proof that Reth is healthy
