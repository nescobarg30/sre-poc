variable aws_reg {
  description = "This is aws region"
  default     = "us-east-1"
  type        = string
}

variable ssh_key {
  default     = "~/.ssh/id_rsa.pub"
  description = "Default pub key"
}

variable ssh_priv_key {
  default     = "~/.ssh/id_rsa"
  description = "Default pub key"
}
