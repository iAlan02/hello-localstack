package terraform

# Ensure API Gateway Rest APIs set an endpoint configuration (REGIONAL or PRIVATE preferred)
deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_api_gateway_rest_api"
  after := rc.change.after
  ec := after.endpoint_configuration
  ec == null
  msg = sprintf("API Gateway %s missing endpoint_configuration (should be REGIONAL or PRIVATE)", [rc.address])
}

deny contains msg if {
  rc := input.resource_changes[_]
  rc.type == "aws_api_gateway_rest_api"
  after := rc.change.after
  ec := after.endpoint_configuration
  ec != null
  types := ec.types
  types != null
  # deny if only EDGE is present (prefer REGIONAL or PRIVATE)
  some i
  types[i] == "EDGE"
  not any_regional_or_private(types)
  msg = sprintf("API Gateway %s uses EDGE endpoint; prefer REGIONAL or PRIVATE", [rc.address])
}

any_regional_or_private(types) if {
  some i
  types[i] == "REGIONAL"
}

any_regional_or_private(types) if {
  some i
  types[i] == "PRIVATE"
}
