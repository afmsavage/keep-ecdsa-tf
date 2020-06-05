
provider "aws" {
  region = var.region
}

resource aws_instance "keep-ecdsa" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3a.small"
  security_groups = [aws_security_group.keep.id]
  user_data       = file("user_data.sh")


  tags = {
    Name = "keep-ecdsa-ubt-20.04"
  }
}

resource aws_security_group "keep" {
  name        = "allow_ecdsa"
  description = "Allow port 3919"

  ingress {
    from_port   = 3919
    to_port     = 3919
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

}

#----------------------------------------------------------------
# Upload wallet.json to directory
#----------------------------------------------------------------
resource "local_file" "wallet" {
  sensitive_content = file("${path.module}/wallet/keep_wallet.json") # Marked as sensitive content, no output or diffs
  filename          = "$HOME/keep-ecdsa/keystore/keep_wallet.json"
}

#TODO: Figure this out
#----------------------------------------------------------------
# Creating SSH Key to use on the instance
#----------------------------------------------------------------
# resource "aws_key_pair" "keep-ecdsa" {

# }

#----------------------------------------------------------------
# Cloudwatch Monitoring
#----------------------------------------------------------------
# TODO: https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html
