variable "account_id" {
  description = "Account ID"
  type = string
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket to store the web app files in"
  type = string
  default = "sd-01-single-page-application"
}

variable "s3_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  type = string
  default = "sd-01-single-page-application.s3.eu-central-1.amazonaws.com"
}
