# Policy for IAM
resource "aws_iam_policy" "allow_iam_actions" {
  name        = "glue-workshop-allow-iam-actions"
  description = "Policy for Glue workshop"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:ListRoles"
        ],
        Resource = "*",
        # Condition = {
        #   StringEquals = {
        #     "iam:ResourceTag/PathPrefix": "/glue/"
        #   }
        # }
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = [aws_iam_role.glue_workshop_role.arn]
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "allow_iam_attachment" {
  group      = aws_iam_group.workshop_group.name
  policy_arn = aws_iam_policy.allow_iam_actions.arn
}

# Policy for Glue
resource "aws_iam_policy" "allow_glue_actions" {
  name        = "workshop-allow-glue-actions"
  description = "Allow actions on Glue resources prefixed with '<name>-workshop'"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowGlue",
        Effect = "Allow",
        Action = "glue:*",
        Resource = [
          "arn:aws:glue:${var.region}:${var.account_id}:catalog",
          "arn:aws:glue:${var.region}:${var.account_id}:database/*",
          "arn:aws:glue:${var.region}:${var.account_id}:table/*/*",
          "arn:aws:glue:${var.region}:${var.account_id}:job/*",
          "arn:aws:glue:${var.region}:${var.account_id}:userDefinedFunction/*/*",
        ]
      },
      {
        Effect   = "Allow",
        Action   = ["glue:Get*"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "allow_glue_attachment" {
  group      = aws_iam_group.workshop_group.name
  policy_arn = aws_iam_policy.allow_glue_actions.arn
}

# Policy for S3
locals {
  s3_buckets = [
    for i in range(length(aws_s3_bucket.workshop_raw_data_bucket)) : {
      raw_data_arn       = aws_s3_bucket.workshop_raw_data_bucket[i].arn
      processed_data_arn = aws_s3_bucket.workshop_processed_data_bucket[i].arn
    }
  ]
}

resource "aws_iam_policy" "allow_s3_actions" {
  name        = "workshop-allow-s3-actions"
  description = "Allow actions on S3 resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowS3",
        Effect = "Allow",
        Action = "s3:*",
        Resource = concat(
          ["arn:aws:s3:::aws-glue-assets-*"],
          flatten([
            for bucket in local.s3_buckets : [
              bucket.raw_data_arn,
              "${bucket.raw_data_arn}/*",
              bucket.processed_data_arn,
              "${bucket.processed_data_arn}/*"
            ]
          ])
        )
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "allow_s3_attachment" {
  group      = aws_iam_group.workshop_group.name
  policy_arn = aws_iam_policy.allow_s3_actions.arn
}

# Policy for CloudWatch logs
resource "aws_iam_policy" "allow_log_group_actions" {
  name        = "workshop-allow-log-group-actions"
  description = "Allow actions on specific CloudWatch Logs log group"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowLogGroup",
        Effect = "Allow",
        Action = [
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ],
        Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws-glue/python-jobs/*:*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "allow_log_group_attachment" {
  group      = aws_iam_group.workshop_group.name
  policy_arn = aws_iam_policy.allow_log_group_actions.arn
}
