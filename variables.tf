
#----------------------------------------------------------------
# Variables Section
#----------------------------------------------------------------

variable "region" {
  description = "AWS Region to spin up your node - Pass in during apply"
  type        = string
  default     = "us-west-2" # cheapest default region
}

variable "accesskey" {
  description = "AWS Access Key - Pass in during apply"
  type        = string
  default     = ""
}

variable "secretkey" {
  description = "AWS Secret Key - Pass in during apply"
  type        = string
  default     = ""
}

variable "public" {
  description = "ETH Public Key - Pass in during apply"
  type        = string
  default     = ""
}

variable "passwd" {
  description = "Password to unlock wallet file - Pass in during apply"
  type        = string
  default     = ""
}

variable alarm_email {
  description = "Email which will receive monitoring alerts"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "SSH key name to attach to ec2 instance"
  type        = string
  default     = "keep-ecdsa"
}

variable "infura" {
  description = "Infura project ID"
  type        = string
  default     = ""
}
