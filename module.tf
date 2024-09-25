###########
# Modules #
###########
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
