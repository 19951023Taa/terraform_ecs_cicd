module "rtb_public" {
  source = "../modules/vpc_routetable"

  vpc_id     = module.vpc_main.vpc_id
  table_name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-public-route-01"
  routes     = local.public.routes
}

module "rtb_private" {
  source = "../modules/vpc_routetable"

  vpc_id     = module.vpc_main.vpc_id
  table_name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-private-route-01"
  routes     = local.private.routes
}


locals {
  public = {
    name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-public-route-01"
    routes = {
      rt01 = {
        destination_cidr_block = "0.0.0.0/0"
        gateway_id             = module.vpc_main.igw_id
      }
    }
  }

  private = {
    name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-private-route-01"
    routes = {
      rt01 = {
        destination_cidr_block = "0.0.0.0/0"
        nat_gateway_id         = module.vpc_natgateway.natgateway_id
      }
    }
  }
}