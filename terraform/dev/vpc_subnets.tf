module "vpc_subnets" {
  source   = "../modules/vpc_subnet"
  for_each = var.subnet_cidrs

  name   = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-${replace(each.key, "_", "-")}"
  vpc_id = module.vpc_main.vpc_id

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
}

resource "aws_route_table_association" "this" {
  for_each  = var.subnet_cidrs
  subnet_id = module.vpc_subnets["${each.key}"].subnet_id
  route_table_id = (
    substr("${each.key}", 0, 6) == "public" ? module.rtb_public.table_id :
    substr("${each.key}", 0, 7) == "private" ? module.rtb_private.table_id :
    ""
  )
}