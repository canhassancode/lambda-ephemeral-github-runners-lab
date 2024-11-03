resource "aws_cloudwatch_log_group" "github_runner_logs" {
  name              = "/aws/lambda/dev/${var.environment}-${var.repo}-github-runner-lambda"
  retention_in_days = 7
}
