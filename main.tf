
terraform {
  required_version = ">=0.12.26"
}

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
  instance_type   = "t3a.small" # 2x2 instance. $8/mo about.  Change to t3a.micro for a 2x1 or a t2.micro for a free instance (1x1)
  security_groups = [aws_security_group.keep.name, aws_security_group.ssh.name]
  user_data       = templatefile("user_data.sh", { public = var.public, password = var.passwd })
  key_name        = var.key_name
  monitoring      = true
  root_block_device {
    volume_size = 40 # setting root block device to 40GB to handle larger log size on main net
  }

  tags = {
    Name = "keep-ecdsa-node"
  }
}
