resource "aws_ecr_repository" "my_ecr_repo" {
  name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecr"

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ecr"
  }
}