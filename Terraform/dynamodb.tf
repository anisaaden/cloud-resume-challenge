resource "aws_dynamodb_table" "visitor-dynamodb-table" {
  name           = "MyCRCtable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "record_id"

  attribute {
    name = "record_id"
    type = "S"
  }


  ttl {
    attribute_name = ""
    enabled        = false
  }

  tags = var.common_tags

}
