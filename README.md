
# KEEP-ECDSA Node Terraform for AWS

The files in this repo will automatically spin you up an Ubuntu node in AWS with the folder structure and required packages

## Getting ready

### Install Terraform

Install Terraform from [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

### Configure your AWS access keys and AWS CLI

Download and install the AWS CLI.  This will be required if you want to utilize email and SMS alerts configured in this module.  Download and installation instructions can be found at [this link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).  Once installed, run `aws configure` to configure your credentials.

**IF YOU DON'T WANT TO INSTALL THE AWS CLI FOR MONITORING**
Have your AWS Access key and Secret keys ready to pass in as variables during the run cmd or have your AWS credential store setup in `~/.aws/credentials` and `~/.aws/config`.  See [this AWS document for assistance](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) configuring them locally

### Create your staking wallet

Your Ethereum public address and password protected `keep_wallet.json` file

### Generate ssh key

This can be done in one of two ways.  If you are on a Mac or Linux based machine, use ssh-agent to generate the ssh key.  If on Windows, you can use WSL or Git Bash if you have Git installed.  Instructions can be found here[https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Go into the AWS Console and generate a keypair that you will use for this machine.  Instructions can be found here[https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).  

**IMPORTANT**: Name the key `keep-ecdsa` to work with the Terraform automatically or if you named it something different, be prepared to pass in a `-var 'keypair=NAME'` variable at runtime

## How to use

We will be building all of the needed `config` files and environment variables required to get your node up and running.  You will still be required to log in to the server and start the keep-ecdsa Docker container yourself

1. Download a `.zip` of this repository or `git clone` it to your local machine
2. Open a CLI into this directory
3. Place your private wallet file into the wallet directory and rename it to `keep_wallet.json`.  This file is marked as sensitive in the Terraform so it will not be output anywhere
4. Run `terraform init` to download the required providers
5. Optional: Run a `terraform plan` to see what will be applied to your AWS account
6. Run `terraform apply` and when prompted, type `yes` to proceed with the node creation

### Windows

```Powershell
tf apply `
 -var 'public=0x...' `
 -var 'passwd=...' `
 -var 'accesskey=...' `
 -var 'secretkey=...' `
 -var 'alarm_email=...'
```

#### Linux/MacOS

```bash
tf apply \
 -var 'public=...' \
 -var 'passwd=...' \
 -var 'accesskey=...' \
 -var 'secretkey=...' \
 -var 'alarm_email=...'
```

## Connecting to the server

Once the `terraform apply` cmd is complete, you should see public_ip and an IP address.  Use the public_ip to ssh into your server using the private ssh key you created earlier

## Approve your email subscription

After the build, you will receive an email confirmation for subscribing to the alerts setup in the Terraform for your node.  You will need to click `Confirm subscription` in the email

## Destroying your server

If you want to delete your node and other resources, run `tf destroy` with the same `-var` arguments you ran in the 