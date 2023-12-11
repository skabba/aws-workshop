# Generate random password
resource "random_password" "password" {
  count            = var.user_count
  length           = 12
  special          = true
  override_special = "!@#$%^&*"
  min_special      = 1
  min_numeric      = 1
  min_lower        = 1
  min_upper        = 1
}

# Create the IAM user
resource "aws_iam_user" "workshop_user" {
  count = var.user_count
  name  = "${var.workshop_name}-workshop-${count.index}"
}

resource "aws_iam_user_login_profile" "user_login" {
  count = var.user_count
  user  = aws_iam_user.workshop_user[count.index].name

  provisioner "local-exec" {
    command = "sleep 15 && aws iam update-login-profile --user-name ${self.user} --password '${random_password.password[count.index].result}' --no-password-reset-required"
  }
}
