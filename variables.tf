###########
# Default #
###########
variable "default_tags" {
  description = "Default tags"
  type        = map(string)
  default     = {}
}

###################################
# Project and Environment details #
###################################
variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "environment_name" {
  description = "Name of environment"
  type        = string
  default     = "dev"
}

variable "region_name" {
  description = "name of aws region. if not set value, it automatically set providers current region."
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "list of availability zones which use"
  type        = list(string)
  default     = ["a", "b"]
}

#######
# VPC #
#######
variable "vpc_cidr" {
  description = "CIDR Block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "Must be a valid IP range in x.x.x.x/x notation"
  }
}

#######
# NAT #
#######
variable "without_nat" {
  description = "Boolean value for using nat gateway or not"
  type        = bool
  default     = false
}

variable "create_nat_per_az" {
  description = "Boolean value for create nat gateway per availability zones. If value is true, create nat gateway per azs, if false create only 1 nat gateway and share it"
  type        = bool
  default     = true
}

variable "nat_deploy_module" {
  description = "The name of the module in which to deploy the NAT gateway. Module is key value of public_subnets variable."
  type        = string
  default     = null
}

##################
# Public Subnets #
##################
variable "public_subnets" {
  description = "Configurations of public subnet"
  type        = list(object({
    name = string
    cidr_list = list(string)
    tag = optional(map(any))
    map_public_ip_on_launch = optional(bool)
  }))

  # validation {
  #   condition = alltrue(concat([for key, cidr_list in var.public_subnets : [
  #     for cidr in cidr_list : can(cidrnetmask(cidr))
  #   ]]...))
  #   error_message = "Must be a valid IP range in x.x.x.x/x notation"
  # }
}

# variable "public_subnets_map_ip_on_launch" {
#   description = "Enable map_public_ip_on_launch on public subnet"
#   type        = bool
#   default     = false
# }

###################
# Private Subnets #
###################
# variable "private_subnets" {
#   description = "Configurations of private subnet"
#   type        = map(list(string))

#   validation {
#     condition = alltrue(concat([for key, cidr_list in var.private_subnets : [
#       for cidr in cidr_list : can(cidrnetmask(cidr))
#     ]]...))
#     error_message = "Must be a valid IP range in x.x.x.x/x notation"
#   }
# }

# variable "private_subnets_tag" {
#   description = "Setting tag to specific private subnet"
#   type        = map(map(string))
#   default     = {}
# }
