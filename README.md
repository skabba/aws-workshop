# aws_workshop
General workshop preperation project for AWS accounts.
Uses Terraform.

# How to plan (example)
```bash
terraform init && \
terraform plan \
  -var="account_alias=xxx-playground" \
  -var="account_id=123456789101" \
  -var="user_count=1" \
  -var="region=eu-west-3" \
  -var="owner=Your Name" \
  -var="workshop_name=glue" \
  -var="enable_glue_policy=true" \
  -var="enable_s3=true"
```

# How to apply (example)
```bash
terraform init && \
terraform apply \
  -var="account_alias=xxx-playground" \
  -var="account_id=123456789101" \
  -var="user_count=1" \
  -var="region=eu-west-3" \
  -var="owner=Your Name" \
  -var="workshop_name=glue" \
  -var="enable_glue_policy=true" \
  -var="enable_s3=true"
```
