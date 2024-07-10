# CodeBuildプロジェクト
resource "aws_codebuild_project" "build_project" {
  name       = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-build_project"
  description = "CodeBuild example project"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "container/buildspec.yml"
  }

  cache {
    type     = "NO_CACHE"
  }
}


# CodeBuild用IAMロールの定義
resource "aws_iam_role" "codebuild_role" {
  name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-CodeBuildRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "codebuild.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-CodeBuildRole"
  }
}

# CodeBuild用のポリシー作成
resource "aws_iam_policy" "CodeBuild_policy" {
  name        = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-CodeBuild_policy"
  description = "CodeBuild_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-1:${data.aws_caller_identity.this.account_id}:log-group:/aws/codebuild/terraform-ecscicd-dev-build_project",
                "arn:aws:logs:ap-northeast-1:${data.aws_caller_identity.this.account_id}:log-group:/aws/codebuild/terraform-ecscicd-dev-build_project:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-1-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-1:${data.aws_caller_identity.this.account_id}:report-group/terraform-ecscicd-dev-build_project-*"
            ]
        }
    ]
  })
}

# CodeBuild用IAMロールのポリシーアタッチ
resource "aws_iam_role_policy_attachment" "BuildRole_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.codebuild_role.name
}

# CodeBuild用IAMロールのポリシーアタッチ
resource "aws_iam_role_policy_attachment" "BuildRole_2" {
  policy_arn = aws_iam_policy.CodeBuild_policy.arn
  role       = aws_iam_role.codebuild_role.name
}