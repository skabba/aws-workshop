# Glue workshop role
resource "aws_iam_role" "glue_workshop_role" {
  name = "glue-workshop-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
      },
    ]
  })
}

# S3
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.glue_workshop_role.name
  policy_arn = aws_iam_policy.allow_s3_actions.arn
}

# Glue
resource "aws_iam_role_policy_attachment" "glue_workshop_role_policy_attachment" {
  role       = aws_iam_role.glue_workshop_role.name
  policy_arn = aws_iam_policy.allow_glue_actions.arn
}

# Athena access
resource "aws_iam_role_policy_attachment" "athena_workshop_role_policy_attachment" {
  role       = aws_iam_role.glue_workshop_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}
