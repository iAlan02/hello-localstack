resource "aws_lambda_function" "hello_fc" {
  filename         = "hello_fc.zip"
  function_name    = "aws_hello_fc"
  handler          = "index.handler"
  source_code_hash = fileexists("hello_fc.zip") ? base64sha256(filebase64("hello_fc.zip")) : null
  runtime          = "nodejs14.x"
  role             = aws_iam_role.iam_hello_fc.arn
  depends_on = [
    data.archive_file.hello_file
  ]
}
