# syntax=docker/dockerfile:1
FROM golang:1.19.1 as BUILDER

RUN apt update && apt install -y build-essential git
WORKDIR /geth
ARG VERSION=v1.10.25
RUN git clone --quiet --branch ${VERSION} --depth 1 https://github.com/ethereum/go-ethereum .
RUN go run build/ci.go install -static ./cmd/geth

FROM alpine:latest

ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV DISCOVERY_PORT=40605
ENV ADDRESS=0.0.0.0
ENV PORT=30303
ENV SYNCMODE=full
ENV EXTRAFLAGS=""
ENV DATA_DIR=/root/.ethereum
ENV BOOTNODES=

WORKDIR /root/
COPY --from=BUILDER /geth/build/bin/geth /usr/local/bin/

RUN apk add --no-cache bash \
    && wget https://raw.githubusercontent.com/Bitgert/brise-chain/master/brise_mainnet.json

RUN mkdir ${DATA_DIR} \
    geth -datadir ${DATA_DIR} init brise_mainnet.json

EXPOSE 8545 8546 40605 40605/udp

ENTRYPOINT geth --datadir ${DATA_DIR} --ipcdisable --port ${DISCOVERY_PORT} --syncmode ${SYNCMODE} --txlookuplimit 0 --cache 1600 --http --http.addr ${ADDRESS} --http.port=${HTTP_PORT} --http.vhosts '*' --http.corsdomain '*' --http.api 'personal,eth,net,web3,personal,admin,miner,txpool,debug' --ws --ws.addr ${ADDRESS} --ws.port ${WS_PORT} --ws.origins '*' -bootnodes=${BOOTNODES} --networkid 32520 ${EXTRAFLAGS}
