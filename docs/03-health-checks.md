# Health Checks

The only health signal that really matters is whether the execution head is progressing correctly.

## What to sample

Sample these repeatedly:
- local `eth_blockNumber`
- public Shape `eth_blockNumber`
- decimal lag
- local `eth_syncing`
- `optimism_syncStatus`
- latest local block hash
- latest public block hash once close to sync

## Healthy signs

Healthy or converging signs:
- local head rises over repeated samples
- lag versus public Shape head shrinks
- `op-node` keeps deriving without repeated engine or forkchoice complaints
- `safe_l2` and `unsafe_l2` move in a way that matches real execution progress

Once fully caught up, a good final check is:
- local and public latest block number match
- local and public latest block hash match
- `eth_chainId` is `360`
- `eth_syncing` is `false`

## Misleading signs

These are not enough on their own:
- containers are running
- `eth_syncing=false`
- `unsafe_l2` moved once
- `net_peerCount=0`

## Quick commands

Local head:
```bash
curl -s -H 'content-type: application/json'   --data '{"jsonrpc":"2.0","id":1,"method":"eth_blockNumber","params":[]}'   http://127.0.0.1:18545 | jq -r '.result'
```

Public head:
```bash
curl -s -H 'content-type: application/json'   --data '{"jsonrpc":"2.0","id":1,"method":"eth_blockNumber","params":[]}'   https://mainnet.shape.network | jq -r '.result'
```

Rollup sync status:
```bash
curl -s -H 'content-type: application/json'   --data '{"jsonrpc":"2.0","id":1,"method":"optimism_syncStatus","params":[]}'   http://127.0.0.1:19545 | jq
```

## Interpretation rules

- report block heights in decimal
- compare more than one sample
- if local head is flat while `unsafe_l2` moves, treat that as suspicious
- if lag is not shrinking, the node is not healthy yet
