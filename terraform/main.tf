terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    version = "~> 5.80.0" }
  }
}

provider "aws" {
  region = "us-west-1"

}

variable "main_bucket" {
  description = "Nombre del bucket principal"
  type        = string
}

locals {
  base_bucket_name = toset([var.main_bucket])
}

resource "aws_s3_bucket" "buckets" {
  for_each = local.base_bucket_name

  bucket        = each.value
  force_destroy = true
  tags = {
    name        = each.value
    environment = "dev"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  for_each = local.base_bucket_name

  bucket = aws_s3_bucket.buckets[each.key].id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_html" {
  for_each = local.base_bucket_name

  bucket = aws_s3_bucket.buckets[each.key].id
  key = "index.html"
  content_type = "text/html"

  content = <<HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Backup - ${each.key}</title>
</head>
<body>
  <h1>Backup del Bucket: ${each.key}</h1>
  <p>Este es el archivo index.html generado para el bucket ${each.key}.</p>
</body>
</html>
HTML
}

resource "aws_s3_bucket_policy" "public_read" {
  for_each = local.base_bucket_name

  bucket = aws_s3_bucket.buckets[each.key].id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadForWebsite",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.buckets[each.key].arn}/*"
    }]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

resource "aws_s3_bucket_website_configuration" "website" {
  for_each = local.base_bucket_name

  bucket = aws_s3_bucket.buckets[each.key].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "CloudFront distribution for ${var.main_bucket}"

  origin {
    domain_name = aws_s3_bucket_website_configuration.website[var.main_bucket].website_endpoint
    origin_id   = "S3-${var.main_bucket}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-${var.main_bucket}"
    viewer_protocol_policy = "redirect-to-https"
    cached_methods         = ["GET", "HEAD"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    name        = "cdn-${var.main_bucket}"
    environment = "dev"
  }

  depends_on = [
    aws_s3_bucket_website_configuration.website
  ]
}
