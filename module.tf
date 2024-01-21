################################################################################
# Modules
################################################################################
module "region" {
  source  = "cawcaw253/region/aws"
  version = "1.0.0"

  region_name        = var.region_name
  availability_zones = var.availability_zones
}

module "namer" {
  source  = "cawcaw253/namer/aws"
  version = "1.0.0"

  prefix = [
    var.project_name,
    var.environment_name,
  ]
}

# module "vpc_namer" {
#   source = "./modules/terraform-hanwha-namer-3.0.3"

#   project_name     = var.project_name
#   environment_name = var.environment_name
#   region_name      = var.region_name
# }

# module "igw_namer" {
#   source = "./modules/terraform-hanwha-namer-3.0.3"

#   project_name     = var.project_name
#   environment_name = var.environment_name
#   region_name      = var.region_name
# }

# module "public_subnet_namer" {
#   source = "./modules/terraform-hanwha-namer-3.0.3"

#   project_name       = var.project_name
#   environment_name   = var.environment_name
#   region_name        = var.region_name
#   availability_zones = var.availability_zones
#   identifiers        = keys(var.public_subnets)
# }

# module "private_subnet_namer" {
#   source = "./modules/terraform-hanwha-namer-3.0.3"

#   project_name       = var.project_name
#   environment_name   = var.environment_name
#   region_name        = var.region_name
#   availability_zones = var.availability_zones
#   identifiers        = keys(var.private_subnets)
# }

# module "nat_namer" {
#   source = "./modules/terraform-hanwha-namer-3.0.3"

#   project_name       = var.project_name
#   environment_name   = var.environment_name
#   region_name        = var.region_name
#   availability_zones = var.availability_zones
#   resource_types     = ["nat"]
# }
