output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.webapp_cloudfront.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.webapp_cloudfront.id
}
