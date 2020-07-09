#!/bin/bash

sudo apt update
sudo apt install docker.io nodejs -y
mkdir -p /home/ubuntu/keep-ecdsa/{config,keystore,persistence}
sudo chown -R ubuntu /home/ubuntu/keep-ecdsa/

cat <<EOF >>/home/ubuntu/.bashrc

export ETHNODE=https://cloudflare-eth.com/
export ETH_WALLET=${public}
export KEEP_CLIENT_ETHEREUM_PASSWORD=${password}
export SERVER_IP=$(curl ifconfig.me)
export INFURA_PROJECT_ID="${infura}"
EOF

export ETHNODE=https://cloudflare-eth.com/
export ETH_WALLET=${public}
export KEEP_CLIENT_ETHEREUM_PASSWORD=${password}
export SERVER_IP=$(curl ifconfig.me)
export INFURA_PROJECT_ID="${infura}"
# TODO: Finalize the mainnet cat
# TODO: Test Cloudflare websocket endpoint

cat <<CONFIG >>/home/ubuntu/keep-ecdsa/config/config.toml

# Connection details of ethereum blockchain.
[ethereum]
  URL = "wss://ropsten.infura.io/ws/v3/${infura}"
  URLRPC = "https://ropsten.infura.io/v3/${infura}"


[ethereum.account]
  Address = "${public}"
  KeyFile = "/mnt/keep-ecdsa/keystore/keep_wallet.json"


# This address might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
[ethereum.ContractAddresses]
  BondedECDSAKeepFactory = "0x17caddf97a1d1123efb7b233cb16c76c31a96e02"


# This addresses might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
# Addresses of applications approved by the operator.
[SanctionedApplications]
  Addresses = [
    "0x14dC06F762E7f4a756825c1A1dA569b3180153cB",
]

[Storage]
  DataDir = "/mnt/keep-ecdsa/persistence"

[LibP2P]
  Peers = ["/dns4/ecdsa-0.test.keep.network/tcp/3919/ipfs/16Uiu2HAmCcfVpHwfBKNFbQuhvGuFXHVLQ65gB4sJm7HyrcZuLttH",
"/dns4/ecdsa-1.test.keep.network/tcp/3919/ipfs/16Uiu2HAm3eJtyFKAttzJ85NLMromHuRg4yyum3CREMf6CHBBV6KY",
"/dns4/ecdsa-2.test.keep.network/tcp/3919/ipfs/16Uiu2HAmNNuCp45z5bgB8KiTHv1vHTNAVbBgxxtTFGAndageo9Dp",
"/dns4/ecdsa-3.test.keep.network/tcp/3919/ipfs/16Uiu2HAm8KJX32kr3eYUhDuzwTucSfAfspnjnXNf9veVhB12t6Vf",
"/dns4/ecdsa-4.test.keep.network/tcp/3919/ipfs/16Uiu2HAkxRTeySEWZfW9C83GPFpQUXvrygmZryCN6DL4piZrbAv4",
"/dns4/bootstrap-1.ecdsa.keep.test.boar.network/tcp/4001/ipfs/16Uiu2HAmPFXDaeGWtnzd8s39NsaQguoWtKi77834A6xwYqeicq6N"]

# Override the node’s default addresses announced in the network
AnnouncedAddresses = ["/ip4/$SERVER_IP/tcp/5678"]

[TSS]
# Timeout for TSS protocol pre-parameters generation. The value
# should be provided based on resources available on the machine running the client.
# This is an optional parameter, if not provided timeout for TSS protocol
# pre-parameters generation will be set to .
  PreParamsGenerationTimeout = "2m30s"
CONFIG

git clone https://github.com/knarz/keep-setup.git
npm --prefix /home/ubuntu/keep-setup install /keep-setup
node /keep-setup/keystore.js ${password}