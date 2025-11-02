output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "bastion_public_ip" {
  description = "Bastion public IP"
  value       = module.bastion.bastion_public_ip
}

output "cluster_autoscaler_role_arn" {
  description = "Cluster autoscaler role ARN"
  value       = module.eks.cluster_autoscaler_role_arn
}

output "ebs_csi_driver_role_arn" {
  description = "EBS CSI driver role ARN"
  value       = module.eks.ebs_csi_driver_role_arn
}

