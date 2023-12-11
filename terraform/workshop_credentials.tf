resource "local_file" "user_credentials_json" {
  count    = var.user_count
  filename = "${path.module}/user_credentials/${aws_iam_user.workshop_user[count.index].name}.json"

  content = <<EOF
{
  "Login": "https://${var.account_alias}.signin.aws.amazon.com/console",
  "Username": "${aws_iam_user.workshop_user[count.index].name}",
  "Password": "${random_password.password[count.index].result}",
  "Cloud9 URL": "https://${var.region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.user_environment[count.index].id}",
  ${var.enable_s3 ? "\"S3 raw bucket\": \"https://s3.console.aws.amazon.com/s3/buckets/${aws_s3_bucket.workshop_raw_data_bucket[count.index].id}?region=${var.region}&tab=objects\"" : ""},
  ${var.enable_s3 ? "\"S3 processed bucket\": \"https://s3.console.aws.amazon.com/s3/buckets/${aws_s3_bucket.workshop_processed_data_bucket[count.index].id}?region=${var.region}&tab=objects\"" : ""},
}
EOF
}
