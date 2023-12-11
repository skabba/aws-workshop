variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "account_alias" {
  description = "AWS Account Alias"
  type        = string
}

variable "user_count" {
  description = "Number of users to create"
  type        = number
}

variable "workshop_name" {
  description = "Workshop Name"
  type        = string
}

variable "iam_group_policy_arns" {
  description = "List of policy ARNs to attach to the group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AWSCloud9User",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
  ]
}

variable "enable_glue_policy" {
  description = "Set to true to enable the creation of the Glue IAM policy"
  type        = bool
  default     = false
}

variable "enable_s3" {
  description = "Set to true to enable the creation of S3 buckets"
  type        = bool
  default     = false
}
