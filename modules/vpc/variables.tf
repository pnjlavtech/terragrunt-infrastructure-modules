variable "database_subnets" {
  description = "Database subnets"
  type        = list(string)
}

variable "database_subnet_tags" {
  description = "Database subnet tags"
  type        = map(string)

  default = {
    module-component      = "subnet"
    module-component-type = "subnet-database"
  }
}

variable "eks_name" {
  description = "Kubernetes EKS Name"
  type        = string
}

variable "environment" {
  description = "Environment name for project"
  type        = string
  default     = "environment"
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "private_subnet_tags" {
  description = "Private subnet tags"
  type        = map(string)

  default = {
    module-component      = "subnet"
    module-component-type = "subnet-private"
  }
}

# variable "public_domain" {
#   description = "Public DNS zone name"
#   type        = string

#   default = "$DOMAINNAME"
# }

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "public_subnet_tags" {
  description = "Public subnet tags"
  type        = map(string)

  default = {
    module-component      = "subnet"
    module-component-type = "subnet-public"
  }
}

# variable "region" {
#   description = "AWS Region where resources will be deployed"
#   type        = string
#   default     = "us-west-2"
# }

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
  default     = "10.230.0.0/16"
}