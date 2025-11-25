package terraform

allowed_runtimes := {
  "python3.9",
  "python3.10",
  "nodejs16.x",
  "nodejs18.x",
  "provided.al2"
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_lambda_function"

  after := rc.change.after
  runtime := after.runtime
  runtime != null

  not runtime in allowed_runtimes

  msg = sprintf(
    "Lambda %s uses disallowed runtime '%s'",
    [rc.address, runtime],
  )
}
