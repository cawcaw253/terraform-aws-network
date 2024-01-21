<!-- BEGIN_TF_DOCS -->
# Terraform AWS Network Module

Terraform module which creates VPC, Subnet, IG, EIP, NAT Gateway on AWS.

## Example

```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_namer"></a> [namer](#module\_namer) | cawcaw253/namer/aws | 1.0.0 |
| <a name="module_region"></a> [region](#module\_region) | cawcaw253/region/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | list of availability zones which use | `list(string)` | <pre>[<br>  "a",<br>  "b"<br>]</pre> | no |
| <a name="input_create_nat_per_az"></a> [create\_nat\_per\_az](#input\_create\_nat\_per\_az) | Boolean value for create nat gateway per availability zones. If value is true, create nat gateway per azs, if false create only 1 nat gateway and share it | `bool` | `true` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags | `map(string)` | `{}` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of environment | `string` | `"dev"` | no |
| <a name="input_nat_deploy_module"></a> [nat\_deploy\_module](#input\_nat\_deploy\_module) | The name of the module in which to deploy the NAT gateway. Module is key value of public\_subnets variable. | `string` | `null` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Configurations of private subnet | `map(list(string))` | n/a | yes |
| <a name="input_private_subnets_tag"></a> [private\_subnets\_tag](#input\_private\_subnets\_tag) | Setting tag to specific private subnet | `map(map(string))` | `{}` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Configurations of public subnet | `map(list(string))` | n/a | yes |
| <a name="input_public_subnets_tag"></a> [public\_subnets\_tag](#input\_public\_subnets\_tag) | Setting tag to specific public subnet | `map(map(string))` | `{}` | no |
| <a name="input_region_name"></a> [region\_name](#input\_region\_name) | name of aws region. if not set value, it automatically set providers current region. | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR Block for the VPC | `string` | n/a | yes |
| <a name="input_without_nat"></a> [without\_nat](#input\_without\_nat) | Boolean value for using nat gateway or not | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of Availability Zones where subnets were created |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | The ID of the Internet Gateway |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | IDs of the NAT Gateways created |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | IDs of the created private route tables |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | CIDR list of private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | ID list of private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | IDs of the created public route tables |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | CIDR list of public subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | ID list of public subnets |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The primary IPv4 CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |
<!-- END_TF_DOCS -->