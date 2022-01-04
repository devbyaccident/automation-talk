data "aws_caller_identity" "current" {}

data "aws_kms_key" "aws_s3_key" {
  key_id = "alias/aws/s3"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "demo-bucket-${data.aws_caller_identity.current.account_id}"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.logging_bucket
    target_prefix = "log/atos-demo-bucket-log"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.aws_s3_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}