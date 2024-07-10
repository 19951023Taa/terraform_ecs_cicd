terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
  }
  backend "s3" {
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      "Env" = var.ENV
      "Sys" = local.SYSTEM
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"

  default_tags {
    tags = {
      "Env" = var.ENV
      "Sys" = local.SYSTEM
    }
  }
}

data "aws_caller_identity" "this" {}

data "aws_elb_service_account" "this" {}

data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

data "aws_canonical_user_id" "this" {}