package terraform

deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket"

  after := rc.change.after
  acl := after.acl
  acl == "public-read"

  msg = sprintf("S3 bucket %s has public ACL '%s'", [rc.address, acl])
}

# --- Public policy: Principal = "*"
deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket"

  after := rc.change.after
  policy := after.policy
  policy != null

  contains(policy, "\"Principal\": \"*\"")

  msg = sprintf(
    "S3 bucket %s has a policy with a wildcard principal",
    [rc.address],
  )
}

# --- Public policy: Principal.AWS = "*"
deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket"

  after := rc.change.after
  policy := after.policy
  policy != null

  contains(policy, "\"Principal\": { \"AWS\": \"*\" }")

  msg = sprintf(
    "S3 bucket %s has a policy with a wildcard principal",
    [rc.address],
  )
}
