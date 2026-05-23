#!/usr/bin/env bash
set -euo pipefail

LOCAL_RPC=${LOCAL_RPC:-http://127.0.0.1:18545}
PUBLIC_RPC=${PUBLIC_RPC:-https://mainnet.shape.network}
OP_NODE_RPC=${OP_NODE_RPC:-http://127.0.0.1:19545}

need() {
  command -v "$1" >/dev/null 2>&1 || { echo "missing required command: $1" >&2; exit 1; }
}

need curl
need python3

json_rpc() {
  local url="$1"
  local method="$2"
  local params="${3:-[]}"
  curl -s -H 'content-type: application/json'     --data "{"jsonrpc":"2.0","id":1,"method":"${method}","params":${params}}"     "$url"
}

hex_to_dec() {
  python3 - "$1" <<'PY'
import sys
value = sys.argv[1]
if value in (None, '', 'null'):
    print('null')
else:
    print(int(value, 16))
PY
}

LOCAL_HEX=$(json_rpc "$LOCAL_RPC" eth_blockNumber | python3 -c 'import sys,json; print(json.load(sys.stdin).get("result"))')
PUBLIC_HEX=$(json_rpc "$PUBLIC_RPC" eth_blockNumber | python3 -c 'import sys,json; print(json.load(sys.stdin).get("result"))')
SYNCING=$(json_rpc "$LOCAL_RPC" eth_syncing | python3 -c 'import sys,json; import json as j; print(j.dumps(json.load(sys.stdin).get("result")))')

LOCAL_DEC=$(hex_to_dec "$LOCAL_HEX")
PUBLIC_DEC=$(hex_to_dec "$PUBLIC_HEX")
LAG=$(python3 - "$LOCAL_DEC" "$PUBLIC_DEC" <<'PY'
import sys
local = int(sys.argv[1])
public = int(sys.argv[2])
print(public - local)
PY
)

echo "local_head_dec=$LOCAL_DEC"
echo "public_head_dec=$PUBLIC_DEC"
echo "lag_blocks=$LAG"
echo "eth_syncing=$SYNCING"
echo ""
echo "optimism_syncStatus:"
json_rpc "$OP_NODE_RPC" optimism_syncStatus | python3 -m json.tool
