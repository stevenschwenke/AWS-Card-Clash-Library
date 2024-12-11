resource "aws_cloudfront_distribution" "webapp_cloudfront" {
  origin {
    domain_name = var.s3_bucket_regional_domain_name
    origin_id   = var.s3_bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront-origin-access-control.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Webapp Cloudfront Distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.s3_bucket_regional_domain_name

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "sd-01-webapp-cloudfront"
    architecture = "sd-01"
  }
}

resource "aws_cloudfront_origin_access_control" "cloudfront-origin-access-control" {
  name                        = var.s3_bucket_regional_domain_name
  description                 = "Grant CloudFront access to S3 bucket ${aws_s3_bucket.web-app-bucket.id}"
  origin_access_control_origin_type = "s3"
  signing_behavior            = "always"
  signing_protocol            = "sigv4"
}
