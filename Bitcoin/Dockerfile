FROM debian:10-slim AS build

RUN apt update && apt upgrade -y && apt install curl gpg wget python3  binutils -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get autoremove

ENV BITCOIN_LATEST_VERSION=https://api.github.com/repos/bitcoin/bitcoin/releases/latest

RUN export BITCOIN_VERSION=$(curl -s ${BITCOIN_LATEST_VERSION} | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'].replace('v', ''))") && \
    echo "Installing version: $BITCOIN_VERSION" && \ 
    wget "https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz" -O /tmp/bitcoin.tar.gz && \
    tar xzf /tmp/bitcoin.tar.gz -C /tmp && \
    install -m 0755 -o root -g root -t /usr/local/bin /tmp/bitcoin-$BITCOIN_VERSION/bin/* && \
    strip /usr/local/bin/bitcoind && \
    strip /usr/local/bin/bitcoin-cli && \
    rm -rf /tmp/bitcoin.tar.gz /tmp/bitcoin-$BITCOIN_VERSION

FROM debian:10-slim

COPY --from=build /usr/local/bin/bitcoind /usr/local/bin/
COPY --from=build /usr/local/bin/bitcoin-cli /usr/local/bin/
COPY ./run.sh ./run.sh
RUN chmod 777 ./run.sh

EXPOSE 8332 29000

ENTRYPOINT ./run.sh