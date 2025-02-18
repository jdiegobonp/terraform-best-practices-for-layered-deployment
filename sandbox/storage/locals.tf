locals{
    workload_name = "payments"
    environment = "sandbox"
    dynamodb_table_name = "${local.workload_name}-dynamodb-table-${local.environment}"
    rds_instance_name = "${local.workload_name}-rds-instance-${local.environment}"
    rds_security_group_name = "${local.workload_name}-rds-security-group-${local.environment}"
    tags = {
        environment = local.environment
    }
}