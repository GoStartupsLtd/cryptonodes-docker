#!/bin/bash

wget "https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz" \
    && tar xzf bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz \
    && install -m 0755 -o root -g root -t /usr/local/bin bitcoin-$BITCOIN_VERSION/bin/*