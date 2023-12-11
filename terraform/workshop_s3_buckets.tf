resource "random_string" "random" {
  count   = var.enable_s3 ? var.user_count : 0
  length  = 6
  upper   = false
  special = false
}

resource "aws_s3_bucket" "workshop_raw_data_bucket" {
  count  = var.enable_s3 ? var.user_count : 0
  bucket = "${aws_iam_user.workshop_user[count.index].name}-raw-data-bucket-${random_string.random[count.index].result}"
}

resource "aws_s3_bucket" "workshop_processed_data_bucket" {
  count  = var.enable_s3 ? var.user_count : 0
  bucket = "${aws_iam_user.workshop_user[count.index].name}-processed-data-bucket-${random_string.random[count.index].result}"
}

# Glue assets bucket
resource "aws_s3_bucket" "glue_assets" {
  bucket = "aws-glue-assets-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}
