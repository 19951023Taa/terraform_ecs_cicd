module "load_balancer" {
  source = "../modules/lb_main"

  lb_name         = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-alb-01"
  internal        = false
  lb_type         = "application"
  security_groups = [module.alb_sg.security_group_id]
  subnets = [
    module.vpc_subnets["public_subnet_a_01"].subnet_id,
    module.vpc_subnets["public_subnet_c_01"].subnet_id
  ]
  enable_deletion_protection       = false
  idle_timeout                     = 60
  enable_cross_zone_load_balancing = true
}

module "target_blue" {
  source = "../modules/lb_target"

  load_balancer_arn             = module.load_balancer.lb_arn
  listener_port                 = 80
  listener_protocol             = "HTTP"
  target_group_name             = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-blue-tg"
  target_group_port             = 8080
  target_group_protocol         = "HTTP"
  vpc_id                        = module.vpc_main.vpc_id
  target_type                   = "ip"
  health_check_interval         = 30
  health_check_path             = "/"
  health_check_protocol         = "HTTP"
  health_check_timeout          = 5
  healthy_threshold             = 3
  unhealthy_threshold           = 3
}

module "target_green" {
  source = "../modules/lb_target"

  load_balancer_arn             = module.load_balancer.lb_arn
  listener_port                 = 8080
  listener_protocol             = "HTTP"
  target_group_name             = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-green-tg"
  target_group_port             = 8080
  target_group_protocol         = "HTTP"
  vpc_id                        = module.vpc_main.vpc_id
  target_type                   = "ip"
  health_check_interval         = 30
  health_check_path             = "/"
  health_check_protocol         = "HTTP"
  health_check_timeout          = 5
  healthy_threshold             = 3
  unhealthy_threshold           = 3
}