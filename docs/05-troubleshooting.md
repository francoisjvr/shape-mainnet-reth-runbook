# Troubleshooting

## Symptom: containers are up, but the node is not really syncing

Check:
- repeated local head samples
- repeated public head samples
- decimal lag trend
- `optimism_syncStatus`
- recent `op-node` logs
- recent `op-reth` logs

If the local execution head is flat, the node is not healthy yet.

## Symptom: `unsafe_l2` moves but execution head stays flat

Treat this as a red flag.

Likely areas:
- chain-spec mismatch
- runtime config mismatch
- bad or incomplete datadir
- engine wiring problem
- fork handling mismatch

## Symptom: peer count is zero

On current Shape mainnet this is not automatically a failure.

Do not waste time treating EL peer hunting as the first debugging step unless Shape changes the network model.

## Symptom: startup fails after moving from geth

Check for:
- port collisions
- wrong datadir path
- wrong JWT path
- wrong rollup or genesis file path
- accidentally pointing at the old geth runtime

## Symptom: imported snapshot behaves strangely

Check:
- nested extracted directory structure
- stale lock files after confirmed clean shutdown
- source config files versus runtime config files
- whether the snapshot actually matches Shape mainnet

## Logs worth checking first

```bash
docker logs --tail 100 shape-mainnet-op-reth
```

```bash
docker logs --tail 100 shape-mainnet-op-node-reth
```

## Escalation rule

If health is ambiguous, classify honestly:
- healthy
- converging
- stalled
- broken

Do not declare success early.
