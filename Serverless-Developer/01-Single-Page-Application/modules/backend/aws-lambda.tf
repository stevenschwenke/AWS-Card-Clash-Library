resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "DynamoDbInlinePolicy" {
  name = "DynamoDbInlinePolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:PutItem",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem"
        ],
        "Resource": "arn:aws:dynamodb:eu-central-1:${var.account_id}:table/Fortunes"
      }
    ]
  })
}

resource "aws_lambda_function" "get-fortune" {
  filename         = "${path.module}/assets/get-fortune.zip"
  function_name    = "get-fortune"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "get-fortune.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("${path.module}/assets/get-fortune.zip")
}

resource "aws_api_gateway_integration" "get-fortune_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fortune_rest_api.id
  resource_id             = aws_api_gateway_resource.api_resource_fortune.id
  http_method             = aws_api_gateway_method.api_method_get_fortune.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get-fortune.invoke_arn
}

