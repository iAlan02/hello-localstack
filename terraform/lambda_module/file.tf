data "archive_file" "hello_file" {
  type        = "zip"
  source_file = "${path.module}/${var.filename}.js"
  output_path = "${path.module}/${var.filename}.zip"
}