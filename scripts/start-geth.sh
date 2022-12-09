#!/bin/sh
#
# Starts a local fast-synced geth node.

DEFAULT_NETWORK=lukso

if [ "$NETWORK" = "" ]; then
	NETWORK=$DEFAULT_NETWORK
fi

if [ "$PRUNE_GETH" != "" ]; then
    exec geth snapshot prune-state --datadir.ancient=/root/ancient-data
elif [ "$START_GETH" != "" ]; then
	if [ "$NETWORK" != "$DEFAULT_NETWORK" ]; then
		exec geth --goerli --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable --authrpc.addr "0.0.0.0" --authrpc.port "8551" --authrpc.vhosts "*" --authrpc.jwtsecret "/root/jwttoken"
	else
		exec geth --ws --ws.api "net,eth,debug,engine" --nat extip:$EXTERNAL_IP --http --http.api "net,eth,debug,engine" --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --mine --miner.threads 1 --miner.gaslimit 60000000 --miner.etherbase 0x8eFdC93aE5FEa9287e7a22B6c14670BfcCdA997b --datadir.ancient=/root/ancient-data --authrpc.addr "0.0.0.0" --authrpc.port "8551" --authrpc.vhosts "*" --authrpc.jwtsecret "/root/jwttoken/jwtsecret.hex"
	fi
fi
