module "lambda" {
  source = "./lambda_module"

  lambda_name = "test_lambda"
  filename = "test_lambda"
}


module "api" {
  source = "./api_module"

  lambda_name = "test_lambda"
  lambda_invoke_arn = module.lambda.lambda_arn

  depends_on = [ module.lambda ]
}