resource "aws_api_gateway_rest_api" "hello-api" {
    name = "HelloApi"
    description = "API to call Alan's world"
}

resource "aws_api_gateway_resource" "hello-resource" {
    rest_api_id = aws_api_gateway_rest_api.hello-api.id
    parent_id = aws_api_gateway_rest_api.hello-api.root_resource_id
    path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "hello-method" {
    rest_api_id = aws_api_gateway_rest_api.hello-api.id
    resource_id = aws_api_gateway_resource.hello-resource.id
    http_method = "ANY"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "hello-integration" {
    rest_api_id = aws_api_gateway_rest_api.hello-api.id
    resource_id = aws_api_gateway_resource.hello-resource.id
    http_method = aws_api_gateway_method.hello-method.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.hello_fc.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.hello-api.id
   resource_id   = aws_api_gateway_rest_api.hello-api.root_resource_id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.hello-api.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.hello_fc.invoke_arn
}

resource "aws_api_gateway_deployment" "hello-deployment" {
    rest_api_id = aws_api_gateway_rest_api.hello-api.id
    depends_on = [
      aws_api_gateway_integration.hello-integration,
      aws_api_gateway_integration.lambda_root
    ]
    stage_name = "test"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_fc.function_name
  principal     = "apigateway.amazonaws.com"


  source_arn = "${aws_api_gateway_rest_api.hello-api.execution_arn}/*/*/*"
}

output "endpoint" {
  value = aws_api_gateway_deployment.hello-deployment.invoke_url
}