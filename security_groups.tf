#----------------------------------------------------------------
# security groups
#----------------------------------------------------------------
# allow keep port
resource aws_security_group "keep" {
  name        = "allow-ecdsa"
  description = "Allow port 3919(keep ecdsa communication port)"

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
  description = "allow ssh access to the server"

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
