package infra

import (
	"encoding/json"
)

// map role: members
#Policy: [role=string]: [...string]

_#Policy: {
	policy_data: string | *"{}"
	_policy:     #Policy
	if len(_policy) > 0 {
		policy_data: json.Marshal({
			bindings: [ for _role, _members in _policy {
				role:    _role
				members: _members
			}]
		})
	}
	...
}
