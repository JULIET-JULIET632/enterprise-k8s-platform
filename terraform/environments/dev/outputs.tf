output "vpc_id" {
  description = "ID of the dev VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the dev public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the dev private subnets"
  value       = module.networking.private_subnet_ids
}

output "instance_ids" {
  description = "IDs of the Kubernetes EC2 nodes"
  value       = module.compute.instance_ids
}

output "node_private_ips" {
  description = "Private IP addresses of the Kubernetes nodes"
  value       = module.compute.private_ips
}

output "security_group_id" {
  description = "Security group ID attached to the Kubernetes nodes"
  value       = module.compute.security_group_id
}
