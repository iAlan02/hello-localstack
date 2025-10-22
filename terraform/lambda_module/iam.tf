resource "aws_iam_role" "iam_hello_fc" {
  name               = "tf-hello-role"
  assume_role_policy = <<EOF
{
    "Version" : "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
   EOF
}
