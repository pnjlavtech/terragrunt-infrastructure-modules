variable "database_subnets" {
  description = "Database subnets"
  type        = []
}

variable "eks_name" {
  description = "Kubernetes EKS Name"
  type        = string
}

variable "environment" {
  description = "Environment name for project"
  type        = string

  default = "eks_argocd"
}

variable "private_subnets" {
  description = "Private subnets"
  type        = []
}

variable "public_domain" {
  description = "Public DNS zone name"
  type        = string

  default = "$DOMAINNAME"
}

variable "public_subnets" {
  description = "Public subnets"
  type        = []
}

variable "region" {
  description = "AWS Region where resources will be deployed"
  type        = string

  default = "us-west-2"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)

  default = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC where resources will be deployed"
  type        = string
}