#!/bin/bash

echo "Installing version: $ETHEREUM_VERSION"

git clone https://github.com/ethereum/go-ethereum && \
    cd go-ethereum && \
    git checkout ${ETHEREUM_VERSION} && \
    make geth && \
    ln -s /home/go-ethereum/build/bin/geth /usr/local/bin

cd /home/ && \
    curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output prysm.sh && chmod +x prysm.sh