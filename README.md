
# KEEP-ECDSA Node Terraform for AWS (TESTNET VERSION)

The files in this repo will automatically spin you up an Ubuntu node in AWS with the folder structure and required packages.  You can refer to [https://gist.github.com/afmsavage/8fc19937a6b263f05c3e215d8860629c](https://gist.github.com/afmsavage/8fc19937a6b263f05c3e215d8860629c) for more information about the configuration that is performed automatically by this module.  That gist is a walkthrough on how to manually setup an ECDSA node on either the testnet or the mainnet

__**Features**__

- Monitoring
- **Email Alerts** for instance down and high resource usage
- Automatically create the `keep-ecdsa` node config and folder structure
- Install the necessary programs such as Docker
  
## Getting ready

Clone the git repo or download a zip of the files here

```bash
git clone git@github.com:afmsavage/keep-ecdsa-tf.git
cd keep-ecdsa-tf
```

## Get an infura account

You will need an Infura account to run this on testnet.  Remember to pass your Infura project ID into the project at runtime so it can map the info to the correct part of the configuration

### Install Terraform

Download the Terraform binary from [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) or run one of the following commands to install it automatically

#### MacOS/Linux

```brew install terraform```

#### Windows

```scoop install terraform```

or

```choco install terraform```

### Configure your AWS access keys and AWS CLI

Download and install the AWS CLI.  This will be required if you want to utilize email and SMS alerts configured in this module.  Download and installation instructions can be found at [this link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).  Once installed, run `aws configure` to configure your credentials.

**IF YOU DON'T WANT TO INSTALL THE AWS CLI FOR MONITORING**
Have your AWS Access key and Secret keys ready to pass in as variables during the run cmd or have your AWS credential store setup in `~/.aws/credentials` and `~/.aws/config`.  See [this AWS document for assistance](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) configuring them locally

### Create your staking wallet

Your Ethereum public address and password protected `keep_wallet.json` file.  The password to unlock the wallet will be automatically added to environment variables and ready to unlock it inside of the keep-ecdsa Docker container

### Generate ssh key

This can be done in one of two ways.  If you are on a Mac or Linux based machine, use ssh-agent to generate the ssh key.  If on Windows, you can use WSL or Git Bash if you have Git installed.  Instructions can be found here[https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Go into the AWS Console and generate a keypair that you will use for this machine.  Instructions can be found here[https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).  

**IMPORTANT**: Name the key `keep-ecdsa` to work with the Terraform automatically or if you named it something different, be prepared to pass in a `-var 'keypair=NAME'` variable at runtime

## How to use

We will be building all of the needed `config` files and environment variables required to get your node up and running.  You will still be required to log in to the server and start the keep-ecdsa Docker container yourself

1. Open a CLI into the keep-ecdsa-tf directory
2. Run `terraform init` to download the required Terraform providers
3. Optional: Run a `terraform plan` to see what will be applied to your AWS account
4. Run `terraform apply` and when prompted, type `yes` to proceed with the node creation

### Variables

These are the variables which are accepted at creation

| var name    | Description                                | value type | required? |
|-------------|--------------------------------------------|------------|-----------|
| public      | public IP address of your wallet           | string     | yes       |
| passwd      | password to unlock your wallet.json file   | string     | yes       |
| accesskey   | AWS access key                             | string     | yes       |
| secretkey   | AWS secret key                             | string     | yes       |
| alarm_email | Email which will receive monitoring alerts | string     | yes       |
| infura      | Infura project ID                          | string     | yes       |
| key_name    | ssh key name if not using `keep-ecdsa`     | string     | no        |
| region      | region to create the server in             | string     | no        |

### Windows Cmd

```Powershell
tf apply `
 -var 'public=0x...' `
 -var 'passwd=...' `
 -var 'accesskey=...' `
 -var 'secretkey=...' `
 -var 'alarm_email=...' `
 -var 'infura=...'
```

#### Linux/MacOS Cmd

```bash
tf apply \
 -var 'public=...' \
 -var 'passwd=...' \
 -var 'accesskey=...' \
 -var 'secretkey=...' \
 -var 'alarm_email=...' \
 -var 'infura=...'
```

## Connecting to the server

Once the `terraform apply` cmd is complete, you should see `public_ip` and an IP address.  Use the `public_ip` to ssh into your server using the private ssh key you created earlier

## Approve your email subscription

After the build, you will receive an email confirmation for subscribing to the alerts setup in the Terraform for your node.  You will need to click `Confirm subscription` in the email

## Uploading your keep-wallet.json

Your private key/wallet file will need to be uploaded to the instance into the /home/ubuntu/keep-ecdsa/keystore directory.  You can use SCP for this.  I tried to keep this process as trustless as possible

## Destroying your server

If you want to delete your node and other resources, run `tf destroy` with the same `-var` arguments you ran in the apply command

## Start the keep-ecdsa container

When logged into the server, run the following command from the home directory of the Ubuntu user.  This will start the keep-ecdsa container

```bash
sudo docker run -dit \
--restart always \
--entrypoint /usr/local/bin/keep-ecdsa \
--volume $HOME/keep-ecdsa:/mnt/keep-ecdsa \
--env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
--name ec \
--env LOG_LEVEL=debug \
-p 3920:3919 \
keepnetwork/keep-ecdsa-client:latest --config /mnt/keep-ecdsa/config/config.toml start
```

## Optional Changes

You can add the ubuntu user to the Docker group and allow Docker commands without sudo by running these two commands, logging out then log back in.

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```
