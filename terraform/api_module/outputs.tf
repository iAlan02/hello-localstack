output "endpoint" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.hello-api.id}/test/_user_request_/"
}