module "eks" {
  for_each = local.eks_enable ? toset(["eks"]) : toset([])
  source = "git@github.com:terraform-aws-modules/terraform-aws-eks.git?ref=v20.33.1"

  cluster_name                   = local.eks_cluster_name
  cluster_version                = local.eks_cluster_version
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = data.terraform_remote_state.networking.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.networking.outputs.private_subnets

  tags = local.tags
}

resource "aws_ec2_tag" "private_subnets_tag" {
  for_each    = local.eks_enable ? toset(data.terraform_remote_state.networking.outputs.private_subnet_arns) : toset([])
  resource_id = each.key
  key         = "kubernetes.io/role/internal-elb"
  value       = 1
}


resource "aws_ec2_tag" "public_subnets_tag" {
  for_each = local.eks_enable ? toset(data.terraform_remote_state.networking.outputs.public_subnet_arns) : toset([])
  resource_id = each.key
  key         = "kubernetes.io/role/elb"
  value       = 1
}
