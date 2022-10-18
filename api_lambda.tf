resource "aws_apigatewayv2_integration" "lambda_crc" {
  api_id = aws_apigatewayv2_api.record-update.id

  integration_uri    = aws_lambda_function.dynamodb_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "get_lambda" {
  api_id = aws_apigatewayv2_api.record-update.id

  route_key = "GET /lambda_function_CRC"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_crc.id}"
}

resource "aws_apigatewayv2_route" "post_lambda" {
  api_id = aws_apigatewayv2_api.record-update.id

  route_key = "POST /lambda_function_CRC"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_crc.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamodb_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.record-update.execution_arn}/*/*"
}

output "api_base_url" {
  value = aws_apigatewayv2_stage.dev.invoke_url
}