FROM golang:1.16 as builder

WORKDIR /home/
RUN apk add --no-cache make gcc musl-dev linux-headers git

RUN git clone https://github.com/ethereum/go-ethereum && \
    cd go-ethereum && \
    make geth 

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /home/go-ethereum/build/bin/geth /usr/local/bin/

ENV HTTP_PORT=8545
ENV WS_PORT=8546
ENV ADDRESS=127.0.0.1
ENV PORT=30303
ENV SYNCMODE=snap
ENV EXTRAFLAGS=""

EXPOSE 8545 8546 30303 30303/udp
ENTRYPOINT geth --ipcdisable --syncmode ${SYNCMODE} --nat none --txlookuplimit 0 --cache 4096 --port ${PORT} \
--http --http.addr ${ADDRESS} --http.port=${HTTP_PORT} --http.vhosts '*' --http.corsdomain '*' \
--ws --ws.addr ${ADDRESS} --ws.port ${WS_PORT} --ws.origins '*' ${EXTRAFLAGS}
