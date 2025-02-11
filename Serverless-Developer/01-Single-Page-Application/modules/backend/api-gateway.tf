
# API Gateway Rest API
resource "aws_api_gateway_rest_api" "fortune_rest_api" {
  name        = "FortuneAPI"
  description = "API Gateway Rest API for Fortune Cookies"
}

# Lambda Permission for API Gateway to Invoke Lambda Function
resource "aws_lambda_permission" "api_gateway_app_status_get_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-fortune.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fortune_rest_api.execution_arn}/*/*"
}

# API Gateway deployment
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.fortune_rest_api.id

  # Trigger redeployment on changes
  depends_on = [
    aws_api_gateway_integration.get-fortune_lambda_integration
  ]
}


# API Gateway Stage
resource "aws_api_gateway_stage" "api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.fortune_rest_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  stage_name    = "prod"

  variables = {
    "environment" = "prod"
  }
}

