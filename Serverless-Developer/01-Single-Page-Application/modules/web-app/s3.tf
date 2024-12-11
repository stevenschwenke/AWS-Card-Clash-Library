resource "aws_s3_bucket" "web-app-bucket" {

  bucket = var.s3_bucket_name

  force_destroy = true

  tags = {
    Name = var.s3_bucket_name
    architecture = "sd-01"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.web-app-bucket.id
  index_document {
    suffix = "index.html"
  }
    error_document {
      key = "error.html"
    }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.web-app-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# version all changes
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.web-app-bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

# server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.web-app-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_bucket_policy" {
  bucket = aws_s3_bucket.web-app-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = [
          aws_s3_bucket.web-app-bucket.arn,
          "${aws_s3_bucket.web-app-bucket.arn}/*"
        ]
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${var.account_id}:distribution/${aws_cloudfront_distribution.webapp_cloudfront.id}"
          }
        }
      }
    ]
  })
}
