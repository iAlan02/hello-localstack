package terraform

deny contains msg if {
  rc := input.resource_changes[_]
  startswith(rc.type, "aws_iam_")

  after := rc.change.after
  policy := after.policy
  policy != null

  contains(policy, "\"Action\": \"*\"")
  msg = sprintf("IAM policy in %s contains wildcard action '*'", [rc.address])
}

deny contains msg if {
  rc := input.resource_changes[_]
  startswith(rc.type, "aws_iam_")

  after := rc.change.after
  policy := after.policy
  policy != null

  contains(policy, "\"Action\": [ \"*\" ]")
  msg = sprintf("IAM policy in %s contains wildcard action '*'", [rc.address])
}

deny contains msg if {
  rc := input.resource_changes[_]
  startswith(rc.type, "aws_iam_")

  after := rc.change.after
  policy := after.policy
  policy != null

  contains(policy, "\"Action\": [\"*\"]")
  msg = sprintf("IAM policy in %s contains wildcard action '*'", [rc.address])
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_iam_policy_document"

  after := rc.change.after
  stat := after.statement
  stat != null

  some i
  s := stat[i]
  actions := s.actions
  actions != null
  some j
  actions[j] == "*"

  msg = sprintf(
    "IAM policy document %s contains wildcard action '*'",
    [rc.address],
  )
}
