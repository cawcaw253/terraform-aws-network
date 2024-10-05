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

  public_subnets = [
    {
      name = "front"
      cidr_list = ["10.0.0.0/21", "10.0.8.0/21", "10.0.16.0/21", /* "10.0.24.0/21" */]
      tag = {
        "kubernetes.io/role/elb" = "1"
      }
      map_public_ip_on_launch = false
    },
    {
      name = "bastion"
      cidr_list = ["10.0.62.0/26", /* "10.0.62.64/26", */ "10.0.62.128/26", /* "10.0.62.192/26" */]
      tag = {"purpose" = "bastion"}
    },
  ]

  # private_subnets = [
  #   {
  #     name = "personal"
  #     cidr_list = ["10.0.64.0/20", "10.0.80.0/20", "10.0.96.0/20", /* "10.0.112.0/20" */]
  #     tag = {
  #       "kubernetes.io/role/internal-elb" = 1
  #     }
  #   },
  #   {
  #     name = "rest"
  #     cidr_list = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", "10.0.176.0/20"]
  #   },
  # ]  
}
