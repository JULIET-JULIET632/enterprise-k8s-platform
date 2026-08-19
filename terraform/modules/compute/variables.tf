variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Kubernetes nodes"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID used for Kubernetes nodes"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where Kubernetes nodes will run"
  type        = list(string)
}

variable "node_count" {
  description = "Number of Kubernetes worker nodes"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "VPC ID where Kubernetes nodes will be deployed"
  type        = string
}
