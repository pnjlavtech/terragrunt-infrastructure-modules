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

  default = "vpc-0d92a29a969c4f59d"

}
