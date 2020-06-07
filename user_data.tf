
#----------------------------------------------------------------
# Template Creation
#----------------------------------------------------------------

data "template_file" "node-setup" {
  template = file("user_data.sh")

  vars = {
    public   = var.public
    password = var.passwd
    #public_ip = aws_instance.keep-ecdsa.public_ip
  }
}
