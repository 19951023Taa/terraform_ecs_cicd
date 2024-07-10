resource "aws_codecommit_repository" "my_codecommit_repo" {
  repository_name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-repo"
  description     = "MyRepository"

  tags = {
    Name = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-repo"
  }
}