variable "database_subnets" {
  description = "Database subnets"
  type        = list(string)
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
  type        = list(string)
}

variable "public_domain" {
  description = "Public DNS zone name"
  type        = string

  default = "$DOMAINNAME"
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
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
    module = "vpc"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC where resources will be deployed"
  type        = string
}