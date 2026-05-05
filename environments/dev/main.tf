terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "devops-team"
    }
  }
}

module "networking" {
  source = "../../modules/networking"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
}

module "security" {
  source = "../../modules/security"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.networking.vpc_id
  allowed_ssh_ips = var.allowed_ssh_ips
}

module "compute" {
  source = "../../modules/compute"

  project_name       = var.project_name
  environment        = var.environment
  instance_type      = var.instance_type
  subnet_id          = module.networking.public_subnet_id
  security_group_ids = [module.security.security_group_id]
  public_key_path    = var.public_key_path
  root_volume_size   = var.root_volume_size
  # user_data_path     = "${path.root}/../../scripts/user_data.sh"
}