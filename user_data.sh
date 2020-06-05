#!/bin/bash
#TODO: Rename to .tpl
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io
mkdir -p $HOME/keep-ecdsa/{config,keystore,persistence}
cat <<EOF >>$home/.bashrc

export ETHNODE=https://cloudflare-eth.com/
export ETH_WALLET=${wallet}
export KEEP_CLIENT_ETHEREUM_PASSWORD=${password}
EOF

# TODO: Finalize the mainnet cat
# TODO: Figure out how to do the Ethereum public IP thing, $ETH_WALLET
# TODO: Test Cloudflare websocket endpoint
#

cat <<CONFIG >>$HOME/keep-ecdsa/config/config.toml.test

# Connection details of ethereum blockchain.
[ethereum]
  URL = "wss://cloudflare-eth.com/"
  URLRPC = "https://cloudflare-eth.com/"


[ethereum.account]
  Address = "${public}"
  KeyFile = "/mnt/keep-ecdsa/keystore/keep_wallet.json"


# This address might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
[ethereum.ContractAddresses]
  BondedECDSAKeepFactory = "0x18758f16988E61Cd4B61E6B930694BD9fB07C22F"


# This addresses might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
# Addresses of applications approved by the operator.
[SanctionedApplications]
  Addresses = [
    "0x41A1b40c1280883eA14C6a71e23bb66b83B3fB59",
]

[Storage]
  DataDir = "/mnt/keep-ecdsa/persistence"

[LibP2P]
  Peers = ["/dns4/bst-a01.ecdsa.keep.boar.network/tcp/4001/ipfs/16Uiu2HAkzYFHsqbwt64ZztWWK1hyeLntRNqWMYFiZjaKu1PZgikN",
"/dns4/bst-b01.ecdsa.keep.boar.network/tcp/4001/ipfs/16Uiu2HAkxLttmh3G8LYzAy1V1g1b3kdukzYskjpvv5DihY4wvx7D",
"/dns4/keep-boot-validator-0.prod-us-west-2.staked.cloud/tcp/3920/ipfs/16Uiu2HAmDnq9qZJH9zJJ3TR4pX1BkYHWtR2rVww24ttxQTiKhsaJ",
"/dns4/keep-boot-validator-1.prod-us-west-2.staked.cloud/tcp/3920/ipfs/16Uiu2HAmHbbMTDDsT2f6z8zMgDtJkTUDJQSYsQYUpaJjdMjiYNEf",
"/dns4/keep-boot-validator-2.prod-us-west-2.staked.cloud/tcp/3920/ipfs/16Uiu2HAmBXoNLLMYU9EcKYH6JN5tA498sXQHFWk4heK22RfXD7wC",
"/ip4/54.39.179.73/tcp/4001/ipfs/16Uiu2HAkyYtzNoWuF3ULaA7RMfVAxvfQQ9YRvRT3TK4tXmuZtaWi",
"/ip4/54.39.186.166/tcp/4001/ipfs/16Uiu2HAkzD5n4mtTSddzqVY3wPJZmtvWjARTSpr4JbDX9n9PDJRh",
"/ip4/54.39.179.134/tcp/4001/ipfs/16Uiu2HAkuxCuWA4zXnsj9R6A3b3a1TKUjQvBpAEaJ98KGdGue67p"]
Port = 3919

# Override the node’s default addresses announced in the network
AnnouncedAddresses = ["/ip4/${public_ip}/tcp/5678"]

[TSS]
# Timeout for TSS protocol pre-parameters generation. The value
# should be provided based on resources available on the machine running the client.
# This is an optional parameter, if not provided timeout for TSS protocol
# pre-parameters generation will be set to .
  PreParamsGenerationTimeout = "2m30s"
CONFIG