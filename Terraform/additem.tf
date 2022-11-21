resource "aws_dynamodb_table_item" "visitors" {

  table_name = aws_dynamodb_table.visitor-dynamodb-table.name
  hash_key = aws_dynamodb_table.visitor-dynamodb-table.hash_key
  item = <<ITEM
  {
      "record_id": {"S": "visitors"},
      "visitor_count": {"N": "0"}
  }  
