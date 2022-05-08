variable "portas" {
  description = "Portas do security group"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}