terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.55.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      "terraform" = "yes",
      "purpose" = "example",
    }
  }
}
