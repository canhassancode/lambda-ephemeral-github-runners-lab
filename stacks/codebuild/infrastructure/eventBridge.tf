resource "aws_cloudwatch_event_rule" "github_job_trigger" {
  name        = "${var.environment}-${var.repo}-github-job-trigger"
  description = "Triggers Lambda for Github job request for repository: ${var.repo-url}"
  event_pattern = jsonencode({
    "source" : ["aws.codebuild"],
    "detail-type" : ["Codbuild Build State Change"],
    "detail" : {
      "build-status" : ["IN_PROGIRESS"]
    }
  })
}

resource "aws_cloudwatch_event_target" "github_lambda_target" {
  rule = aws_cloudwatch_event_rule.github_job_trigger.name
  arn  = aws_lambda_function.github_runner_lambda.arn
}
