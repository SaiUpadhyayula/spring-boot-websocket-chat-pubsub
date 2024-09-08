#!/bin/bash

# Default values
HOST="dragonfly"
PORT=6379
THREADS=4
CLIENTS=50
REQUESTS=10000

# Run memtier_benchmark on the same Docker network as dragonfly
docker run --rm --network container:dragonfly redislabs/memtier_benchmark:latest -s $HOST -p $PORT -t $THREADS -c $CLIENTS -n $REQUESTS