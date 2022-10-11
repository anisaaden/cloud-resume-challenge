resource "aws_lambda_function" "dynamodb_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "lambdatrigger.zip"
  function_name = "lambda_function_CRC"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"

  runtime = "python3.8"

  tags = var.common_tags

}

