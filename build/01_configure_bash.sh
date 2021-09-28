#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo HELPERS="/home/ubuntu/cardano-helpers" >> /home/ubuntu/.bashrc
echo NODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc
echo NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> /home/ubuntu/.bashrc
echo CARDANO_NODE_SOCKET_PATH="/home/ubuntu/cardano-my-node/db/socket" >> /home/ubuntu/.bashrc

# CNODE_HOME is the same variable as NODE_HOME, but we need to keep this alias around because
# it is a variable that's used in guild-operator's cnode-helper-scripts
echo CNODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc

# symlink a few config files
sudo ln -s /home/ubuntu/cardano-helpers/config/.bash_aliases /home/ubuntu/.bash_aliases
sudo ln -s /home/ubuntu/cardano-helpers/config/poolMetaData.json /home/ubuntu/cardano-my-node/poolMetaData.json

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"