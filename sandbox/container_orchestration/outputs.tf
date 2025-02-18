################################################################################
# Cluster EKS
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = local.eks_enable ? module.eks.cluster_arn : null
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = local.eks_enable ? module.eks.cluster_certificate_authority_data : null
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = local.eks_enable ? module.eks.cluster_endpoint : null
}

output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  value       = local.eks_enable ? module.eks.cluster_id : null
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = local.eks_enable ? module.eks.cluster_name : null
}

################################################################################
# Cluster ECS
################################################################################

output "services" {
  description = "Map of services created and their attributes"
  value       = module.ecs_cluster.services
}

output "ecs_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
  value       = module.ecs_cluster.cluster_arn
}
