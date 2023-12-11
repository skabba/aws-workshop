
# Create the IAM group
resource "aws_iam_group" "workshop_group" {
  name = "${var.workshop_name}-workshop"
}

resource "aws_iam_group_policy_attachment" "workshop_group_policy_attachment" {
  for_each = toset(var.iam_group_policy_arns)

  group      = aws_iam_group.workshop_group.name
  policy_arn = each.value
}

resource "aws_iam_group_membership" "group_membership" {
  name  = aws_iam_group.workshop_group.name
  users = aws_iam_user.workshop_user[*].name
  group = aws_iam_group.workshop_group.name
}
