FROM debian:9-slim

ENV RPC_USER=user
ENV RPC_PASS=pass
ENV RPC_PORT=8332
ENV RPC_ALLOW_IP=127.0.0.1
ENV TESTNET=0
ENV EXTRAFLAGS=""

RUN apt-get update && apt-get upgrade && apt-get install -y wget
RUN wget https://github.com/BTCGPU/BTCGPU/releases/download/v0.17.3/bitcoin-gold-0.17.3-x86_64-linux-gnu.tar.gz
RUN tar xzf bitcoin-gold-0.17.3-x86_64-linux-gnu.tar.gz
RUN install -m 0755 -o root -g root -t /usr/local/bin bitcoin-gold-0.17.3/bin/*

EXPOSE ${RPC_PORT}

ENTRYPOINT bgoldd -rpcuser="$RPC_USER" \
    -rpcpassword="$RPC_PASS" \
    -rpcport="$RPC_PORT" \
    -rpcallowip="${RPC_ALLOW_IP}" \
    -rpcbind=0.0.0.0 \
    -listen \
    -server \
    -testnet=${TESTNET} \
    ${EXTRAFLAGS}
