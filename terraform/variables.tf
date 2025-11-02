variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  default     = "myproject"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "myproject-cluster"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "public_subnet_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["172.16.3.0/24", "172.16.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

# Bastion Configuration
variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "./keys/id_ed25519.pub"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0cfde0ea8edd312d4"
}

variable "instance_type" {
  description = "Instance type for bastion"
  type        = string
  default     = "t3.small"
}

variable "user_data_path" {
  description = "Path to user data script for bastion"
  type        = string
  default     = "./scripts/bastion.sh"
}

variable "my_ip" {
  description = "Your IP address for SSH access"
  type        = string
  default     = "43.229.91.242/32"
}

# KMS Configuration
variable "kms_deletion_window" {
  description = "Days before KMS key is deleted"
  type        = number
  default     = 20
}

# EKS Configuration
variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
  default     = "1.29"
}

variable "node_group_desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "node_group_ami_type" {
  description = "AMI type for node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "node_group_disk_size" {
  description = "Disk size for nodes (GB)"
  type        = number
  default     = 20
}

variable "node_group_instance_types" {
  description = "Instance types for node group"
  type        = string
  default     = "t3.small"
}

variable "node_group_capacity_type" {
  description = "Capacity type for node group"
  type        = string
  default     = "SPOT"
}

variable "node_group_labels" {
  description = "Labels for worker nodes"
  type        = map(string)
  default     = {
    role         = "worker-node"
    type         = "cpu"
    instance_type = "t3.small"
  }
}

variable "max_unavailable" {
  description = "Maximum unavailable nodes during update"
  type        = number
  default     = 1
}

variable "enabled_cluster_log_types" {
  description = "Enabled cluster log types"
  type        = list(string)
  default     = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

variable "service_ipv4_cidr" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "10.100.0.0/16"
}

variable "create_cluster_timeout" {
  description = "Cluster creation timeout"
  type        = string
  default     = "60m"
}

variable "update_cluster_timeout" {
  description = "Cluster update timeout"
  type        = string
  default     = "60m"
}

variable "delete_cluster_timeout" {
  description = "Cluster deletion timeout"
  type        = string
  default     = "60m"
}

# Addon versions
variable "addon_vpc_cni_version" {
  description = "VPC CNI addon version"
  type        = string
  default     = "v1.20.4-eksbuild.1"
}

variable "addon_core_dns_version" {
  description = "CoreDNS addon version"
  type        = string
  default     = "v1.11.4-eksbuild.24"
}

variable "addon_kube_proxy_version" {
  description = "Kube Proxy addon version"
  type        = string
  default     = "v1.29.15-eksbuild.16"
}

variable "addon_aws_ebs_csi_driver_version" {
  description = "EBS CSI Driver addon version"
  type        = string
  default     = "v1.51.0-eksbuild.1"
}

variable "addon_aws_efs_csi_driver_version" {
  description = "EFS CSI Driver addon version"
  type        = string
  default     = "v2.1.13-eksbuild.1"
}

# ECR Configuration
variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "myproject-app"
}