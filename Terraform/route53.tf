resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = var.common_tags
}

resource "aws_route53_key_signing_key" "dnssecksk" {
  name = var.domain_name
  hosted_zone_id = aws_route53_zone.main.hosted_zone_id
  key_management_service_arn = aws_kms_key.domain-dnssec.arn
}

resource "aws_route53_hosted_zone_dnssec" "main" {
  depends_on = [
    aws_route53_key_signing_key.dnssecksk
  ]
  hosted_zone_id = aws_route53_key_signing_key.dnssecksk.hosted_zone_id
}

resource "aws_route53_record" "root-a" {
  zone_id = aws_route53_zone.main.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = aws_cloudfront_distribution.root_s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.root_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = aws_route53_zone.main.zone_id
  name = "www.${var.domain_name}"
  type = "A"

  alias {
    name = aws_cloudfront_distribution.www_s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.www_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}