#!/bin/bash

# Default values
REDIS_HOST="<host>"
REDIS_PORT="<port>"
THREADS=2
CLIENTS=100
REQUESTS=10000
RATIO="1:0"

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h <host>      Redis host (default: localhost)"
    echo "  -p <port>      Redis port (default: 6379)"
    echo "  -t <threads>   Number of threads (default: 4)"
    echo "  -c <clients>   Number of clients (default: 50)"
    echo "  -n <requests>  Number of requests (default: 10000)"
    echo "  -d <size>      Data size in bytes (default: 32)"
    echo "  -r <ratio>     Read:Write ratio (default: 1:10)"
    echo "  -P <pipeline>  Pipeline depth (default: 1)"
    echo "  -D <duration>  Test duration in seconds (default: 60)"
    echo "  --help         Display this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h) REDIS_HOST="$2"; shift 2 ;;
        -p) REDIS_PORT="$2"; shift 2 ;;
        -t) THREADS="$2"; shift 2 ;;
        -c) CLIENTS="$2"; shift 2 ;;
        -n) REQUESTS="$2"; shift 2 ;;
        -d) DATA_SIZE="$2"; shift 2 ;;
        -r) RATIO="$2"; shift 2 ;;
        -P) PIPELINE="$2"; shift 2 ;;
        -D) DURATION="$2"; shift 2 ;;
        --help) usage; exit 0 ;;
        *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

# Run the benchmark
echo "Running Redis benchmark with the following parameters:"
echo "Host: $REDIS_HOST"
echo "Port: $REDIS_PORT"
echo "Threads: $THREADS"
echo "Clients: $CLIENTS"
echo "Requests: $REQUESTS"
echo "Data size: $DATA_SIZE bytes"
echo "Ratio: $RATIO"
echo "Pipeline: $PIPELINE"
echo "Duration: $DURATION seconds"

docker run --rm redislabs/memtier_benchmark:latest \
    --server=$REDIS_HOST \
    --port=$REDIS_PORT \
    --protocol=redis \
    --threads=$THREADS \
    --clients=$CLIENTS \
    --requests=$REQUESTS \
    --ratio=$RATIO \
    --auth= \
    --key-minimum=1 \
    --key-maximum=1000922 \
    --key-pattern=P:P \
    --json-out-file=benchmark_results.json

echo "Benchmark completed. Results saved in benchmark_results.json"