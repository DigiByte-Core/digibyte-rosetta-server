#!/bin/sh

# Filename: docker-entrypoint.sh
# Rosetta-CLI testing

# Wait for Rosetta Server to become available
trials=50 # total: 25 sec

wait_for_node() {
    proto=$1
    host=$2
    port=$3
    path=$4

    url="$proto://$host:$port/$path"
    echo "Waiting for Rosetta Node ($url) to become available..."

    # until $(curl --head --fail $url); do
    until $(curl --output /dev/null --silent --fail $url); do
        trials=$(( $trials - 1 ))
        printf '.'

        for i in `seq 1 5`; do
            sleep 1
        done

        if [ "$trials" -le 0 ]; then
            echo "Node not reachable. Exiting..."
            exit 1
        fi
    done

    echo " Node available!"
}

wait_for_node http $OFFLINE_HOST $OFFLINE_PORT "hello"
wait_for_node http $ONLINE_HOST $ONLINE_PORT "hello"

cat << EOF > digibyte.conf
{
  "network": {
    "blockchain": "DigiByte",
    "network": "regtest"
  },
  "online_url": "http://$ONLINE_HOST:$ONLINE_PORT",
  "data_directory": "/data",
  "http_timeout": 300,
  "tip_delay": 120,
  "memory_limit_disabled": true,
  "compression_disabled": true,
  "construction": {
    "offline_url": "http://$OFFLINE_HOST:$OFFLINE_PORT",
    "results_output_file": "results/construction.json",
    "constructor_dsl_file": "digibyte.ros",
    "prefunded_accounts": [
      {
        "privkey": "a68c3a11e651e8dfd702f057bd669ca6e5d4f6aa23b2c59de90b708121a138a9",
        "account_identifier": {
          "address": "siT2SP53qqdFJP8nGCzj9jV8fv2wD6u3y2"
        },
        "curve_type": "secp256k1",
        "currency": {
          "symbol": "DGB",
          "decimals": 8
        }
      }
    ],
    "end_conditions": {
      "create_account": 10,
      "transfer": 10
    }
  },
  "data": {
    "log_blocks": true,
    "log_transactions": true,
    "log_balance_changes": true,
    "log_reconciliations": true,
    "reconciliation_disabled": false,
    "balance_tracking_disabled": false,
    "initial_balance_fetch_disabled": false,
    "results_output_file": "results/data.json",
    "end_conditions": {
      "index": 104
    }
  }
}
EOF

cat digibyte.conf

# Wait 8 seconds...
sleep 8

# Run Rosetta CLI
echo "Checking Data API..."
./bin/rosetta-cli check:data --configuration-file digibyte.conf

echo "Checking Construction API..."
./bin/rosetta-cli check:construction --configuration-file digibyte.conf
