resource "aws_iam_role" "codebuild_runner_role" {
  name = "${var.environment}-${var.repo}-codebuild-runner-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

# Attach necessary policies (e.g., S3, CloudWatch, VPC, etc.)
resource "aws_iam_policy_attachment" "codebuild_runner_policy" {
  name       = "${aws_iam_role.codebuild_runner_role.name}-policy-attach"
  roles      = [aws_iam_role.codebuild_runner_role.name]
  policy_arn = "arn:aws:iam:aws:policy/AmazonS3FullAccess"
}
