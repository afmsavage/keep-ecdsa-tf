
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
  user_data = templatefile(
    "user_data.sh",
    {
      public   = var.public,
      password = var.passwd
  }) #file("${path.module}/user_data.sh")
  key_name   = var.key_name
  monitoring = true

  tags = {
    Name = "keep-ecdsa-node"
  }
}
