resource "aws_cloud9_environment_ec2" "user_environment" {
  count = var.user_count
  name  = aws_iam_user.workshop_user[count.index].name

  instance_type   = "t3.small"
  image_id        = "amazonlinux-2-x86_64"
  subnet_id       = aws_subnet.private[0].id
  connection_type = "CONNECT_SSM"

  automatic_stop_time_minutes = 60
  owner_arn                   = "arn:aws:iam::${var.account_id}:user/${aws_iam_user.workshop_user[count.index].name}"
}
