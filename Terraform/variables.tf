variable "domain_name" {
  type = string
  description = "The domain name for the website"
}

variable "bucket_name" {
  type = string
  description = "The name of the bucket without the www. prefix. Normally domain_name"
}

variable "table_name" {
  type = string
  description = "The name of the DynamoDB table for the visitor count"
}

variable "key_spec" {
  type = string
  description = "The customer master key specs"
}

variable "key_usage" {
  type = string
  description = "The intended use of the key"
}

variable "common_tags" {
  description = "Common tags you want applied to all components"
}