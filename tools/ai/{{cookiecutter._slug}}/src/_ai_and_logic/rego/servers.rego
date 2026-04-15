# servers.rego -*- opa -*-
# opa eval -d servers.rego -i servers.json "data.servers"
package servers

output[0] := input.values[2]
output[1] := input.values[1]
