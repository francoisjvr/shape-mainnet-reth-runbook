# Bootstrap from Snapshot

This repo assumes a snapshot-first bootstrap whenever possible.

## 1. Stage the snapshot

Put the archive or transferred datadir into:
- `/root/shape-mainnet-op-reth-staging`

If you are using `/root/Upload`, treat it as a transfer cache only.

### Where to get the current snapshot

Do not hardcode a one-off direct archive URL into this repo unless you have revalidated it very recently.

Use the official sources instead:
- Shape docs: [Run a Node](https://docs.shape.network/technical-details/run-a-node)
- Shape docs source: [`content/technical-details/run-a-node.mdx`](https://github.com/shape-network/docs/blob/main/content/technical-details/run-a-node.mdx)
- Current snapshot provider page linked by the docs: [Alchemy Shape snapshots](https://www.alchemy.com/snapshots/shape)

Why this section exists:
- direct snapshot file URLs can rotate
- the docs page is the stable operator entry point
- the docs source is useful if the published page changes and you want to confirm what Shape currently recommends

## 2. Validate the datadir structure

A real Reth datadir should contain at least:
- `db/`
- `static_files/`
- `blobstore/`
- `invalid_block_hooks/`
- `reth.toml`
- `rollup.json`
- `genesis-l2.json`

Before launch, verify:
- `db/mdbx.dat` exists and is substantial
- static file ranges look sane
- `rollup.json` is for Shape mainnet
- nested extraction directories are flattened if needed

## 3. Promote the datadir

If disk is tight, move instead of copy:

```bash
rm -rf /root/shape-mainnet-op-reth-data
mv /root/shape-mainnet-op-reth-staging /root/shape-mainnet-op-reth-data
mkdir -p /root/shape-mainnet-op-reth-staging
```

## 4. Prepare runtime config

Copy source artifacts into the config dir and create runtime copies:

```bash
cp /root/shape-mainnet-op-reth-data/reth.toml /root/.shape-mainnet-op-reth/reth.source.toml
cp /root/shape-mainnet-op-reth-data/rollup.json /root/.shape-mainnet-op-reth/rollup.source.json
cp /root/shape-mainnet-op-reth-data/genesis-l2.json /root/.shape-mainnet-op-reth/genesis-l2.source.json

cp /root/.shape-mainnet-op-reth/reth.source.toml /root/.shape-mainnet-op-reth/reth.runtime.toml
cp /root/.shape-mainnet-op-reth/rollup.source.json /root/.shape-mainnet-op-reth/rollup.runtime.json
cp /root/.shape-mainnet-op-reth/genesis-l2.source.json /root/.shape-mainnet-op-reth/genesis-l2.runtime.json
```

If present:
```bash
cp /root/shape-mainnet-op-reth-data/known-peers.json /root/.shape-mainnet-op-reth/known-peers.source.json
```

## 5. Generate JWT secret

```bash
openssl rand -hex 32 > /root/.shape-mainnet-op-reth/jwt.hex
chmod 600 /root/.shape-mainnet-op-reth/jwt.hex
```

## 6. Start the services

Use the compose file from `examples/docker-compose.yml` after filling in `.env`.

## 7. Verify with repeated samples

Do not stop at “the stack started.”

Verify:
- local head moves
- lag shrinks
- `op-node` derives cleanly
- logs are sane over time
