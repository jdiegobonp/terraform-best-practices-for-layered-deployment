locals {
    workload_name = "payments"
    environment = "sandbox"
    sqs_name = "${local.workload_name}-sqs-${local.environment}"

    ecs_eventbridge_role_name = "${local.workload_name}-sqs-eventbridge-role"

    tags = {
        workload = local.workload_name
        environment = local.environment
    }
}