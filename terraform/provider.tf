provider "aws" {
  region                      = "eu-west-1"
  access_key                  = "fake_access_key"
  secret_key                  = "fake_secret_key"
  # s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda     = "http://localhost:4566"
    s3         = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    iam        = "http://localhost:4566"
  }
}
