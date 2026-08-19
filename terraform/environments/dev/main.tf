module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "compute" {
  source = "../../modules/compute"

  project_name       = var.project_name
  instance_type      = var.instance_type
  ami_id             = data.aws_ami.ubuntu.id
  private_subnet_ids = module.networking.private_subnet_ids
  node_count         = var.node_count
  vpc_id             = module.networking.vpc_id
}
