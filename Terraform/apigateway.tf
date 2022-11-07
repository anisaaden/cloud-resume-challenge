resource "aws_apigatewayv2_api" "record-update" {
  name          = "myCRCapi"
  protocol_type = "HTTP"
   
  tags = var.common_tags
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.record-update.id

  name        = "dev"
  auto_deploy = true

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

resource "aws_api_gateway_usage_plan" "api-plan" {
  name         = "my-usage-plan"
  description  = "throttling and rate limiting API"

  api_stages {
    api_id = aws_apigatewayv2_api.record-update.id
    stage  = aws_apigatewayv2_stage.dev.name
  }

  quota_settings {
    limit  = 50
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 10
    rate_limit  = 10
  }
}

resource "aws_cloudwatch_log_group" "record-update_api_gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.record-update.name}"

  retention_in_days = 14
}


