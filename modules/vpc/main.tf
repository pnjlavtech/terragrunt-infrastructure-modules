terraform {
  required_version = ">= 1.1"



  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
  }
}



locals {
  availability_zones = [
    data.aws_availability_zones.this.names[0],
    data.aws_availability_zones.this.names[1],
    data.aws_availability_zones.this.names[2],
  ]
}





module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8.1"

  database_subnet_ipv6_prefixes                 = [6, 7, 8]
  enable_ipv6                                   = true
  private_subnet_ipv6_prefixes                  = [3, 4, 5]
  public_subnet_assign_ipv6_address_on_creation = true
  public_subnet_ipv6_prefixes                   = [0, 1, 2]

  azs                                             = local.availability_zones
  cidr                                            = var.vpc_cidr
  create_database_subnet_group                    = false
  create_flow_log_cloudwatch_iam_role             = true
  create_flow_log_cloudwatch_log_group            = true
  database_subnets                                = var.database_subnets
  database_subnet_tags                            = var.database_subnet_tags
  enable_dhcp_options                             = true
  enable_dns_hostnames                            = true
  enable_dns_support                              = true
  enable_flow_log                                 = true
  enable_nat_gateway                              = true
  flow_log_cloudwatch_log_group_retention_in_days = 7
  flow_log_max_aggregation_interval               = 60
  name                                            = var.environment
  one_nat_gateway_per_az                          = false
  private_subnet_suffix                           = "private"
  private_subnets                                 = var.private_subnets
  private_subnet_tags                             = var.private_subnet_tags
  public_subnets                                  = var.public_subnets
  public_subnet_tags                              = var.public_subnet_tags
  single_nat_gateway                              = true
  tags                                            = var.tags

  # database_subnet_tags = {
  #   "module-component"      = "subnet"
  #   "module-component-type" = "subnet-database"
  # }
  # private_subnet_tags = {
  #   "module-component"      = "subnet"
  #   "module-component-type" = "subnet-private"
  # }
  # public_subnet_tags = {
  #   "kubernetes.io/cluster/${var.eks_name}" = "shared"
  #   "kubernetes.io/role/elb"                = 1
  # }

}


module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.8.1"

  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  endpoints = {
    s3 = {
      route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      service         = "s3"
      service_type    = "Gateway"
      tags            = { Name = "s3-vpc-endpoint" }
    }
  }
}
