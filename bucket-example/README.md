# Look at existing s3 buckets
`aws s3 ls`

# Scan bucket for security errors (Requires [Checkov](https://github.com/bridgecrewio/checkov))
`checkov -d .`

# Make a new AWS S3 Bucket with Terraform
Bucket will have the following:
- Encryption at rest
- Versioning Enabled
- Bucket Logging Enabled
- Private ACL
- No Public Access

`terraform init && terraform apply --auto-approve`