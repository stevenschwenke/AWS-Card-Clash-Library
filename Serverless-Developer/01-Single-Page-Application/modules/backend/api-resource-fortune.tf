resource "aws_api_gateway_resource" "api_resource_fortune" {
  rest_api_id = aws_api_gateway_rest_api.fortune_rest_api.id
  parent_id   = aws_api_gateway_rest_api.fortune_rest_api.root_resource_id
  path_part   = "fortune"
}

resource "aws_api_gateway_method" "api_method_get_fortune" {
  rest_api_id   = aws_api_gateway_rest_api.fortune_rest_api.id
  resource_id   = aws_api_gateway_resource.api_resource_fortune.id
  http_method   = "GET"
  authorization = "NONE"
}
