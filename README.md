
# KEEP-ECDSA Node Terraform for AWS

The files in this repo will automatically spin you up an Ubuntu node in AWS with the folder structure and required packages

## Getting ready

- Install Terraform from [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
- Have your AWS Access key and Secret keys ready to pass in as variables during the run cmd or have your AWS credential store setup in `~/.aws/credentials` and `~/.aws/config`.  See [this AWS document for assitance](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) configuring them locally
- Your Ethereum public address and password protected `wallet.json` file

## How to use

We will be building all of the needed `config` files and environment variables required to get your node up and running.  You will still be required to log in to the server and start the keep-ecdsa Docker container yourself

1. Download a `.zip` of this repository or `git clone` it to your local machine
2. Open a CLI into this directory
3. Place your private wallet file into the wallet directory and rename it to `keep_wallet.json`.  This file is marked as sensitive in the Terraform so it will not be output anywhere
4. Run `terraform init` to download the required providers
5. Optional: Run a `terraform plan` to see what will be applied to your AWS account
6. Run `terraform apply` and when prompted, type `yes` to proceed with the node creation
7. Use the public_ip that will be output at the end of the `terraform apply` to SSH into your server
    