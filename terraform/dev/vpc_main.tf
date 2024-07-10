module "vpc_main" {
  source = "../modules/vpc_main/"

  cidr_block = "10.0.0.0/16"
  vpc_name   = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-vpc-01"

  enable_dns_hostnames = true
  enable_dns_support   = true

  /* DHCP Option Set */
  enable_dhcp_options = true
  dhcp_opt_set_name   = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-dhcp-optionset-01"

  /* Internet Gateway */
  create_igw = true
  igw_name   = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-igw-01"
}