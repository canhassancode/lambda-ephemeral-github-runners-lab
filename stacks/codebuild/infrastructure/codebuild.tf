resource "aws_codebuild_project" "github_runner" {
  name         = "${var.environment}-${var.repo}-github-runner"
  service_role = aws_iam_role.codebuild_runner_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
  source {
    type            = "GITHUB"
    location        = var.repo-url
    git_clone_depth = 1
  }

  # vpc_config {
  #   vpc_id = ""
  #   subnets = [""]
  #   security_group_ids = [""]
  # }
}
