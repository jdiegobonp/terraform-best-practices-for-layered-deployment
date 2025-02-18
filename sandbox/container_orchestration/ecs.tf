module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.12.0"

  cluster_name = local.ecs_cluster_name

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  create_cloudwatch_log_group = true
  cloudwatch_log_group_name          = "/ecs/${local.workload_name}"

  services = {
    nginx = {
      subnet_ids                         = data.terraform_remote_state.networking.outputs.private_subnets
      desired_count                      = 1
      deployment_maximum_percent         = 100
      deployment_minimum_healthy_percent = 0
      enable_cloudwatch_logging          = true

      security_group_rules = {
        ingress_80 = {
          type                     = "ingress"
          from_port                = "80"
          to_port                  = "80"
          protocol                 = "tcp"
          description              = "Service port"
          cidr_blocks              = ["0.0.0.0/0"]
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
      

      container_definitions = {
        nginx = {
          image  = "nginx",
          cpu    = 1,
          memory = 128
        }
      }
    }
  }
}
