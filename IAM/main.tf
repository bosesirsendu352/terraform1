#Create an IAM group with EC2 Full access privilege and add a user admin1 with password Password123# within that group 
provider "aws" {
  region = "us-east-1" # Change to the appropriate region for your needs
}

resource "aws_iam_group" "example" {
  name = "example-group"
}

resource "aws_iam_policy" "example" {
  name        = "example-policy"
  path        = "/"
  description = "Example policy for EC2 full access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "example" {
  policy_arn = aws_iam_policy.example.arn
  group      = aws_iam_group.example.name
}

resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user_login_profile" "admin1_password" {
  user                    = aws_iam_user.admin1.name
  password_reset_required = true
  password_length         = 12
  password                = "Password123#"
}

resource "aws_iam_group_membership" "admin1_membership" {
  name  = aws_iam_group.example.name
  users = [aws_iam_user.admin1.name]
}

