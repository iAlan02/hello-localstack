resource "aws_lambda_function" "hello_fc" {
  filename         = data.archive_file.hello_file.output_path
  function_name    = "${var.lambda_name}"
  handler          = "${var.filename}.handler"
  source_code_hash = fileexists("${var.filename}.zip") ? base64sha256(filebase64("${var.filename}.zip")) : null
  runtime          = "nodejs14.x"
  role             = aws_iam_role.iam_hello_fc.arn
  depends_on = [
    data.archive_file.hello_file,
    aws_iam_role.iam_hello_fc
  ]
}
