resource "aws_kms_key" "domain-dnssec" {
  customer_master_key_spec = var.key_spec
  key_usage = var.key_usage
  deletion_window_in_days = 10
  policy = file("${path.module}/Templates/kms_key_policy.json")
  tags = var.common_tags
}