
provider "aws" {
  region     = var.region
  access_key = var.accesskey
  secret_key = var.secretkey
}

#----------------------------------------------------------------
# EC2 Instance
#----------------------------------------------------------------

resource aws_instance "keep-ecdsa" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3a.small"
  security_groups = [aws_security_group.keep.name, aws_security_group.ssh.name]
  user_data       = file("${path.module}/user_data.sh")
  key_pair        = var.key_name
  monitoring      = true


  tags = {
    Name = "keep-ecdsa-node"
  }
}
# allow keep port
resource aws_security_group "keep" {
  name        = "allow-ecdsa"
  description = "Allow port 3919"

  ingress {
    from_port   = 3919
    to_port     = 3919
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "allow-ssh"
  description = "allow ssh access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# TODO: Figure out how to upload file to instance
#----------------------------------------------------------------
# Upload wallet.json to directory
#----------------------------------------------------------------
# resource "local_file" "wallet" {
#   sensitive_content = file("${path.module}/wallet/keep_wallet.json") # Marked as sensitive content, no output or diffs
#   filename          = "$HOME/keep-ecdsa/keystore/keep_wallet.json"
# }

