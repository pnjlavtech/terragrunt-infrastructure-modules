# variable "argocd_chart_version" {
#   description = "ArgoCD Helm Chart Version"
#   type        = string

#   default = "6.7.18"
# }

# variable "argocd_helm_settings" {
#   description = "Additional settings for ArgoCD Helm deployment"
#   type        = any

#   default = {
#     server = {
#       extraArgs = ["--insecure"]
#     }
#   }
# }

variable "eks_name" {
  description = "Environment name for project"
  type        = string
  default     = "eks"
}


variable "eks_cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string

  default = "1.29"
}

variable "environment" {
  description = "Environment name for project"
  type        = string

  default = "eks_argocd"
}

variable "private_subnets" {
  description = "List of private subnet ids"
  type        = list(string)
}

variable "public_domain" {
  description = "Public DNS zone name"
  type        = string

  default = "pnjlavtech.com"
}

variable "region" {
  description = "AWS Region where resources will be deployed"
  type        = string

  default = "us-west-2"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)

  default = {
    module = "eks"
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC where resources will be deployed"
  type        = string

  default = "10.230.0.0/16"
}
