resource "aws_security_group" "kubernetes_nodes" {
  name        = "${var.project_name}-kubernetes-nodes"
  description = "Security group for Kubernetes nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "${var.project_name}-kubernetes-nodes"
    Project = var.project_name
    Tier    = "compute"
  }
}

resource "aws_vpc_security_group_egress_rule" "nodes_all_outbound" {
  security_group_id = aws_security_group.kubernetes_nodes.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic from Kubernetes nodes"
}

resource "aws_vpc_security_group_ingress_rule" "nodes_internal" {
  security_group_id = aws_security_group.kubernetes_nodes.id

  referenced_security_group_id = aws_security_group.kubernetes_nodes.id
  ip_protocol                  = "-1"

  description = "Allow Kubernetes nodes to communicate with each other"
}

resource "aws_iam_role" "kubernetes_nodes" {
  name = "${var.project_name}-kubernetes-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name    = "${var.project_name}-kubernetes-nodes-role"
    Project = var.project_name
    Tier    = "compute"
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.kubernetes_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "kubernetes_nodes" {
  name = "${var.project_name}-kubernetes-nodes-profile"
  role = aws_iam_role.kubernetes_nodes.name
}

resource "aws_instance" "kubernetes_node" {
  count = var.node_count

  ami           = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.kubernetes_nodes.name

  user_data = file("${path.module}/user_data.sh")

  subnet_id = var.private_subnet_ids[
    count.index % length(var.private_subnet_ids)
  ]

  vpc_security_group_ids = [
    aws_security_group.kubernetes_nodes.id
  ]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name    = "${var.project_name}-node-${count.index + 1}"
    Project = var.project_name
    Role    = "kubernetes-node"
    Tier    = "compute"
  }
}
