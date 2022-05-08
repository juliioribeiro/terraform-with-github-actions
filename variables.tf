variable "portas" {
  description = "Portas do security group"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

variable "aws_pub_key" {
  description = "Public key para VM na AWS"
  type        = string
}