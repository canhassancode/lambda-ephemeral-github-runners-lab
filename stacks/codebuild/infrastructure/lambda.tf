resource "aws_lambda_function" "github_runner_lambda" {
  function_name = "${var.environment}-${var.repo}-github-runner-lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  timeout       = 30

  environment {
    variables = {
      PROJECT_NAME = aws_codebuild_project.github_runner.name
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.environment}-${var.repo}-lambda-execution-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Action" : "sts.AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  name       = "${var.environment}-${var.repo}-lambda-codebuild-policy-attach"
  roles      = [aws_iam_role.lambda_execution_role.name]
  policy_arn = "" //TODO: Policy with least priveleges
}
