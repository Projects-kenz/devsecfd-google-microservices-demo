
# KMS Module
module "kms" {
  source = "./modules/kms"

  project_name            = var.project_name
  deletion_window_in_days = var.kms_deletion_window
  tags                    = local.tags
}

# VPC Module
module "vpc" {
  source = "github.com/Projects-kenz/terraform-modules//vpc?ref=main"

  project_name        = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones = var.availability_zones
  tags               = local.tags
}

# Bastion Module
module "bastion" {
  source = "github.com/Projects-kenz/terraform-modules//bastion?ref=main"

  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  public_key_path    = var.public_key_path
  user_data_path     = var.user_data_path
  my_ip              = var.my_ip
  vpc_dependencies   = [module.vpc.vpc_id]
  tags               = local.tags
}

# EKS Module
module "eks" {
  source = "github.com/Projects-kenz/terraform-modules//eks?ref=main"

  project_name        = var.project_name
  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = module.vpc.vpc_cidr_block
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnets      = var.public_subnet_cidr
  bastion_sg_id       = module.bastion.bastion_security_group_id
  key_name            = module.bastion.key_name
  kms_key_arn         = module.kms.kms_key_arn

  # Node group configuration
  node_group_desired_size = var.node_group_desired_size
  node_group_max_size     = var.node_group_max_size
  node_group_min_size     = var.node_group_min_size
  node_group_instance_types = var.node_group_instance_types
  node_group_ami_type     = var.node_group_ami_type
  node_group_disk_size    = var.node_group_disk_size
  node_group_capacity_type = var.node_group_capacity_type
  node_group_labels       = var.node_group_labels
  max_unavailable         = var.max_unavailable

  # Cluster configuration
  enabled_cluster_log_types = var.enabled_cluster_log_types
  service_ipv4_cidr         = var.service_ipv4_cidr
  create_cluster_timeout    = var.create_cluster_timeout
  update_cluster_timeout    = var.update_cluster_timeout
  delete_cluster_timeout    = var.delete_cluster_timeout

  # Addon versions
  addon_vpc_cni_version        = var.addon_vpc_cni_version
  addon_core_dns_version       = var.addon_core_dns_version
  addon_kube_proxy_version     = var.addon_kube_proxy_version
  addon_aws_ebs_csi_driver_version = var.addon_aws_ebs_csi_driver_version
  addon_aws_efs_csi_driver_version = var.addon_aws_efs_csi_driver_version

  tags = local.tags
}



locals {
  tags = {
    project   = var.project_name
    managedby = "terraform"
  }
}


