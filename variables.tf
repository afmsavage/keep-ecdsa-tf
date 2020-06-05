
#----------------------------------------------------------------
# Variables Section
#----------------------------------------------------------------

variable "region" {
  description = "AWS Region to spin up your node - Pass in during apply"
  type        = string
  default     = "us-east-2"
}

variable "Accesskey" {
  description = "AWS Access Key - Pass in during apply"
  type        = string
  default     = ""
}

variable "Secretkey" {
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
