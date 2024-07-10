module "vpc_natgateway" {
  source = "../modules/vpc_natgateway"

  name              = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ngw-01"
  subnet_id         = module.vpc_subnets["public_subnet_a_01"].subnet_id
  connectivity_type = "public"
}