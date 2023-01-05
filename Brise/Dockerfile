# syntax=docker/dockerfile:1
FROM golang:1.19.1 as BUILDER

RUN apt update && apt install -y build-essential git
WORKDIR /geth
ARG VERSION=v1.10.23
RUN git clone --quiet --branch ${VERSION} --depth 1 https://github.com/ethereum/go-ethereum .
RUN go run build/ci.go install -static ./cmd/geth

FROM alpine:latest

ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV ADDRESS=0.0.0.0
ENV PORT=30303
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""
ENV DATA_DIR=/root/node
ENV BOOTNODES=

WORKDIR /root/
COPY --from=BUILDER /geth/build/bin/geth /usr/local/bin/

RUN apk add --no-cache bash \
    && wget https://raw.githubusercontent.com/Bitgert/brise-chain/master/brise_mainnet.json
RUN mkdir ${DATA_DIR}
RUN geth --datadir ${DATA_DIR} init brise_mainnet.json

EXPOSE 8545 8546 8551 30303 30303/udp



ENTRYPOINT geth --datadir ${DATA_DIR}  --port ${PORT} --http --http.addr ${ADDRESS} --http.port=${HTTP_PORT} --http.vhosts '*' --http.corsdomain '*' --http.api 'personal,eth,net,web3,personal,admin,miner,txpool,debug' --ws --ws.addr ${ADDRESS} --ws.port ${WS_PORT} --ws.origins '*' --bootnodes ${BOOTNODES} --networkid 32520 
