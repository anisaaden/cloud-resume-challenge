resource "aws_apigatewayv2_api" "record-update" {
  name          = "myCRCapi"
  protocol_type = "HTTP"
   
  tags = var.common_tags
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.record-update.id

  name        = "dev"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 10
    throttling_rate_limit = 10
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.record-update_api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
   tags = var.common_tags
}


resource "aws_cloudwatch_log_group" "record-update_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.record-update.name}"

  retention_in_days = 14
}


