
#----------------------------------------------------------------
# Outputs
#----------------------------------------------------------------

output "public_ip" {
  description = "Public IP Address of the node"
  value       = aws_instance.keep-ecdsa.public_ip
}

output "status" {
  description = "Server status"
  value       = aws_instance.keep-ecdsa.instance_state
}

output "admin_password" {
  description = "Admin user password"
  value       = aws_instance.keep-ecdsa.password_data
}
