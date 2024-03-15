terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

  }
}

provider "aws" {
  region        = var.region
  access_key    = var.access_key
  secret_key    = var.secret_key
}

# VPC and internet gateway 
module "vpc" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc?ref=v1.6.0"

  provision             = true
  internal_cidr         = "10.0.0.0/20"
  name_prefix           = var.name_prefix
  resource_group_name   = var.resource_group_name
}

module "igw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-gateways?ref=v1.2.1"

  name_prefix           = var.name_prefix
  provision             = true
  resource_group_name   = var.resource_group_name
  vpc_name              = module.vpc.vpc_name
}

# Subnets - 1 public, 1 private
module "public_subnet" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  name_prefix           = var.name_prefix
  provision             = true
  region                = var.region
  resource_group_name   = var.resource_group_name
  vpc_name              = module.vpc.vpc_name
  gateways              = module.igw.ids
  label                 = "public"
  multi-zone            = false
  subnet_cidrs          = ["10.0.1.0/24"]
  acl_rules             = []
  availability_zones    = []
}
module "private_subnet" {
  source = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets?ref=v2.3.0"

  name_prefix           = var.name_prefix
  provision             = true
  region                = var.region
  resource_group_name   = var.resource_group_name
  vpc_name              = module.vpc.vpc_name
  gateways              = module.ngw.ids
  label                 = "private"
  multi-zone            = false
  subnet_cidrs          = ["10.0.2.0/24"]
  acl_rules             = []
  availability_zones    = []
}

# NAT Gateway
module "ngw" {
  source = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway?ref=v1.1.1"

  _count                = 1
  name_prefix           = var.name_prefix
  provision             = true
  resource_group_name   = var.resource_group_name
  subnet_ids            = module.public_subnet.subnet_ids
}

module "openshift-cluster" {
    source = "github.com/cloud-native-toolkit/terraform-aws-ocp-sno"

    region                = var.region
    access_key            = var.access_key
    secret_key            = var.secret_key
    base_domain_name      = var.base_domain_name
    cluster_name          = var.cluster_name
    resource_group_name   = var.resource_group_name
    pull_secret           = var.pull_secret
    private_subnet        = module.private_subnet.ids[0]
    public_subnet         = module.public_subnet.ids[0]
    vpc_cidr              = module.vpc.vpc_cidr
    private               = false
    openshift_version     = "4.10"
}