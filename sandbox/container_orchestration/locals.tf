locals{
    workload_name = "payments"
    environment = "sandbox"
    ecs_cluster_name = "${local.workload_name}-ecs-cluster-${local.environment}"

    eks_enable = false
    eks_cluster_name = "${local.workload_name}-eks-cluster-${local.environment}"
    eks_cluster_version = "1.29"
    ecs_logs_kms_key_alias = "${local.workload_name}-ecs-logs-kms-key-${local.environment}"
    ecs_logs_cloud_watch_log_group_name = "${local.workload_name}-ecs-logs-cloud-watch-log-group-${local.environment}"
    tags = {
        environment = local.environment
        workload = local.workload_name
    }
}