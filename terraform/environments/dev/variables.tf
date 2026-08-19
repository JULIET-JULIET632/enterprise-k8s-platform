variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "enterprise-k8s-platform-dev"
}

variable "instance_type" {
  description = "EC2 instance type for Kubernetes nodes"
  type        = string
  default     = "t3.micro"
}

variable "node_count" {
  description = "Number of Kubernetes nodes"
  type        = number
  default     = 2
}
