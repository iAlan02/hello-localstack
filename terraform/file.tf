data "archive_file" "hello_file" {
  type        = "zip"
  source_file  = "../src/index.js"
  output_path = "hello_fc.zip"
}
