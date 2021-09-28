#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Starts the node.

##
if [[ -S "${CARDANO_NODE_SOCKET_PATH}" ]]; then
  if pgrep -f "[c]ardano-node.*.${CARDANO_NODE_SOCKET_PATH}"; then
     echo "ERROR: A Cardano node is already running, please terminate this node before starting a new one with this script. You may run the command `restart`"
     exit 1
  else
    echo "WARN: A prior running Cardano node was not properly shutdown. The socket file still exists. Cleaning it up..."
    unlink "${CARDANO_NODE_SOCKET_PATH}"
  fi
fi

DIRECTORY=$NODE_HOME
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=${DIRECTORY}/${NODE_CONFIG}-topology.json
DB_PATH=${DIRECTORY}/db
SOCKET_PATH=${DIRECTORY}/db/socket
CONFIG=${DIRECTORY}/${NODE_CONFIG}-config.json
KES=${DIRECTORY}/kes.skey
VRF=${DIRECTORY}/vrf.skey
CERT=${DIRECTORY}/node.cert

if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
  # start the block producing node
  /usr/local/bin/cardano-node run \
    --topology "${TOPOLOGY}" \
    --database-path "${DB_PATH}" \
    --socket-path "${SOCKET_PATH}" \
    --host-addr ${HOSTADDR} \
    --port ${PORT} \
    --config ${CONFIG} \
    --shelley-kes-key "${KES}" \
    --shelley-vrf-key "${VRF}" \
    --shelley-operational-certificate "${CERT}"
else
  # start the relay node
  /usr/local/bin/cardano-node run --topology "${TOPOLOGY}" \
    --database-path "${DB_PATH}" \
    --socket-path "${SOCKET_PATH}" \
    --host-addr ${HOSTADDR} \
    --port ${PORT} \
    --config ${CONFIG}
fi