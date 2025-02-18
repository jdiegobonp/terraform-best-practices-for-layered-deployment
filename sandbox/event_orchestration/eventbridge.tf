module "eventbridge" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-eventbridge.git?ref=v3.14.3"

  # Schedules can only be created on default bus
  create_bus = false

  create_role       = true
  role_name         = local.ecs_eventbridge_role_name
  attach_ecs_policy = true
  ecs_target_arns = [
    data.terraform_remote_state.container_orchestration.outputs.services["nginx"].task_definition_arn
  ]

  ecs_pass_role_resources = [data.terraform_remote_state.container_orchestration.outputs.services["nginx"].task_exec_iam_role_arn]

  # Fire every five minutes
  rules = {
    orders = {
      description         = "Cron for Orders"
      state               = "DISABLED" # conflicts with enabled which is deprecated
      schedule_expression = "rate(5 minutes)"
    }
  }

  # Send to a fargate ECS cluster
  targets = {
    orders = [
      {
        name            = "orders"
        arn             = data.terraform_remote_state.container_orchestration.outputs.ecs_arn
        attach_role_arn = true

        ecs_target = {
          # If a capacity_provider_strategy specified, the launch_type parameter must be omitted.
          # launch_type         = "FARGATE"
          task_count              = 1
          task_definition_arn     =  data.terraform_remote_state.container_orchestration.outputs.services["nginx"].task_definition_arn
          enable_ecs_managed_tags = true
          tags = {
            production = true
          }

          network_configuration = {
            assign_public_ip = true
            subnets          = data.terraform_remote_state.networking.outputs.private_subnets
            security_groups  = [data.aws_security_group.default.id]
          }

          # If a capacity_provider_strategy is specified, the launch_type parameter must be omitted.
          # If no capacity_provider_strategy or launch_type is specified, the default capacity provider strategy for the cluster is used.
          capacity_provider_strategy = [
            {
              capacity_provider = "FARGATE"
              base              = 1
              weight            = 100
            },
            {
              capacity_provider = "FARGATE_SPOT"
              weight            = 100
            }
          ]
        }
      }
    ]
  }
}