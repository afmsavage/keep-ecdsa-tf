
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
  instance_type   = "t2.micro" # free instance type
  security_groups = [aws_security_group.keep.name, aws_security_group.ssh.name]
  user_data       = templatefile("user_data.sh", { public = var.public, password = var.passwd, infura = var.infura }) #file("${path.module}/user_data.sh")
  key_name        = var.key_name
  monitoring      = true

  tags = {
    Name = "keep-ecdsa-node"
  }
}
