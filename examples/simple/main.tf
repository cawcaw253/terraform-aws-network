#######
# VPC #
#######
module "network" {
  source = "../../"

  project_name     = "simple"
  environment_name = "example"

  vpc_cidr           = "10.0.0.0/16"
  region_name        = "ap-northeast-2"
  availability_zones = ["a", "c"]

  without_nat       = false
  create_nat_per_az = true
  nat_deploy_module = "bastion"

  public_subnets = {
    front = ["10.0.0.0/21", /* "10.0.8.0/21", */ "10.0.16.0/21", /* "10.0.24.0/21" */]
    # front2  = ["10.0.32.0/21", "10.0.40.0/21", "10.0.48.0/21", "10.0.56.0/21"]
    bastion = ["10.0.62.0/26", /* "10.0.62.64/26", */ "10.0.62.128/26", /* "10.0.62.192/26" */]
  }

  public_subnets_tag = {
    front = {
      "kubernetes.io/role/elb" = 1
    }
  }

  private_subnets = {
    personal = ["10.0.64.0/20", /* "10.0.80.0/20", */ "10.0.96.0/20", /* "10.0.112.0/20" */]
    # rest     = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", "10.0.176.0/20"]
    database = ["10.0.192.0/21", /* "10.0.200.0/21", */ "10.0.208.0/21", /* "10.0.216.0/21" */]
  }

  private_subnets_tag = {
    personal = {
      "kubernetes.io/role/internal-elb" = 1
    }
  }
}
