# コードデプロイ アプリケーション
resource "aws_codedeploy_app" "example" {
  name     = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-codedeploy-app"
  compute_platform = "ECS"
}

# コードデプロイ用IAMロールの定義
resource "aws_iam_role" "DeployRoleForECS" {
  name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-CodeDeployRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "codedeploy.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-CodeDeployRole"
  }
}

# コードデプロイ用IAMロールのポリシーアタッチ
resource "aws_iam_role_policy_attachment" "DeployRoleForECS" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.DeployRoleForECS.name
}

resource "aws_codedeploy_deployment_group" "example" {
  app_name              = aws_codedeploy_app.example.name
  deployment_group_name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-deploy-group"
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn      = aws_iam_role.DeployRoleForECS.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 20
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 20
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.this.name
    service_name = aws_ecs_service.main.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [module.target_blue.lb_listener_arn]
      }

      test_traffic_route {
        listener_arns = [module.target_green.lb_listener_arn]
      }

      target_group {
        name = module.target_blue.target_group_name
      }

      target_group {
        name = module.target_green.target_group_name
      }
    }
  }
}
