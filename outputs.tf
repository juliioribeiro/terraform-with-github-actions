output "subnet_id" {
  value = aws_subnet.subnet[*].id
}

# output "vm_ip" {
#   value = aws_instance.vm.public_ip
# }