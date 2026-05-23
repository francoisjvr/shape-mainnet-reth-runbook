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

## Symptom: startup fails after a layout or runtime change

Check for:
- port collisions
- wrong datadir path
- wrong JWT path
- wrong rollup or genesis file path
- accidentally pointing at the wrong runtime path

## Symptom: imported snapshot behaves strangely

Check:
- nested extracted directory structure
- stale lock files after confirmed clean shutdown
- source config files versus runtime config files
- whether the snapshot actually matches Shape mainnet

## Logs worth checking first

```bash
docker logs -f --tail 100 shape-mainnet-op-reth
```

```bash
docker logs -f --tail 100 shape-mainnet-op-node-reth
```

Note:
- `-f` means **follow**
- if a container is quiet, the command can appear to "hang" while it waits for new log lines
- if you want a one-shot snapshot instead, drop `-f`

One-shot snapshot examples:

```bash
docker logs --tail 100 shape-mainnet-op-reth
```

```bash
docker logs --tail 100 shape-mainnet-op-node-reth
```

Both at once:

```bash
docker logs -f --tail 50 shape-mainnet-op-reth &
docker logs -f --tail 50 shape-mainnet-op-node-reth
```

If those names still do not match your machine, discover the exact container names first:

```bash
docker ps --format '{{.Names}}' | grep 'shape-mainnet'
```

If you are using Compose from this repo, this also works:

```bash
docker compose -f examples/docker-compose.yml ps
```

## Escalation rule

If health is ambiguous, classify honestly:
- healthy
- converging
- stalled
- broken

Do not declare success early.
