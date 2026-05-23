#!/usr/bin/env bash
set -euo pipefail

RETH_RUNTIME_DIR=${RETH_RUNTIME_DIR:-/root/shape-mainnet-op-reth-data}
RETH_STAGING_DIR=${RETH_STAGING_DIR:-/root/shape-mainnet-op-reth-staging}
OP_NODE_RUNTIME_DIR=${OP_NODE_RUNTIME_DIR:-/root/shape-mainnet-op-node-data}
CONFIG_DIR=${CONFIG_DIR:-/root/.shape-mainnet-op-reth}

mkdir -p   "$RETH_RUNTIME_DIR"   "$RETH_STAGING_DIR"   "$OP_NODE_RUNTIME_DIR"   "$CONFIG_DIR"

printf 'Created or confirmed:
'
printf '  %s
' "$RETH_RUNTIME_DIR" "$RETH_STAGING_DIR" "$OP_NODE_RUNTIME_DIR" "$CONFIG_DIR"
