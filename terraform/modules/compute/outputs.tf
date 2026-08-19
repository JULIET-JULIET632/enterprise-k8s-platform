output "instance_ids" {
  description = "IDs of the Kubernetes EC2 nodes"
  value       = aws_instance.kubernetes_node[*].id
}

output "private_ips" {
  description = "Private IP addresses of the Kubernetes nodes"
  value       = aws_instance.kubernetes_node[*].private_ip
}

output "security_group_id" {
  description = "Security group ID attached to the Kubernetes nodes"
  value       = aws_security_group.kubernetes_nodes.id
}
