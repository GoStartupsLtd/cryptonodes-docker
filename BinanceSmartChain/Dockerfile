FROM ubuntu:latest

WORKDIR /home/bsc

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y wget curl unzip
RUN wget $(curl -s https://api.github.com/repos/bnb-chain/bsc/releases/latest |grep browser_ |grep geth_linux |cut -d\" -f4)
RUN wget $(curl -s https://api.github.com/repos/bnb-chain/bsc/releases/latest |grep browser_ |grep mainnet |cut -d\" -f4)
RUN unzip mainnet.zip
RUN chmod +x geth_linux
# Pull Geth into a second stage deploy alpine container

ENV HTTP_PORT=18545
ENV WS_PORT=18546
ENV ADDRESS=127.0.0.1
ENV PORT=30311
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""

EXPOSE 18545 18546 30311 30311/udp

COPY config.toml ./config.toml
RUN ./geth_linux --datadir ./init-dir init genesis.json

ENTRYPOINT cp -rn ./init-dir /root/.ethereum && ./geth_linux --ipcdisable --syncmode ${SYNCMODE} --nat none --rpc.allow-unprotected-txs --txlookuplimit 0 --cache 4096 --port ${PORT} \
--http --http.addr ${ADDRESS} --http.port=${HTTP_PORT} --http.vhosts '*' --http.corsdomain '*' \
--ws --ws.addr ${ADDRESS} --ws.port ${WS_PORT} --ws.origins '*' ${EXTRAFLAGS} --config ./config.toml
