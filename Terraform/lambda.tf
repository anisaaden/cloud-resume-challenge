resource "aws_lambda_function" "dynamodb_lambda" {
  filename      = "lambdatrigger.zip"
  function_name = "lambda_function_CRC"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function_v2.lambda_handler"

  runtime = "python3.8"

  tags = var.common_tags

}

