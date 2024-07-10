# ECSクラスター
resource "aws_ecs_cluster" "this" {
  name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecs-cluster"
  }
}

# タスク起動用IAMロールの定義
resource "aws_iam_role" "ecs_execution" {
  name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecs-task-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecs-task-role"
  }
}

# タスク起動用IAMロールへのポリシー割り当て
resource "aws_iam_role_policy_attachment" "ecs_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_execution.name
}

resource "aws_ecs_task_definition" "task" {
  family                   = "container-cicd-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "test-container"
      image     = "${data.aws_caller_identity.this.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/terraform-ecscicd-dev-ecr:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = "ap-northeast-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/example-container"
  retention_in_days = 7
}

resource "aws_ecs_service" "main" {
  name            = "test-app-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
  subnets = [
    module.vpc_subnets["private_subnet_a_01"].subnet_id,
    module.vpc_subnets["private_subnet_c_01"].subnet_id
  ]
    security_groups  = [module.ecs_sg.security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = module.target_blue.target_group_arn
    container_name   = "test-container"
    container_port   = 8080
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [task_definition, load_balancer]
  }
}


