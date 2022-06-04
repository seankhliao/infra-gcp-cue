package infra

import (
	"strings"
)

_artifact_registry: [string]: #ArtifactRegistry
#ArtifactRegistry: {
	id:          string
	description: string | *""
	format:      string | *"DOCKER"
	location:    string | *REGION
	policy:      #Policy | *[]
	url:         "\(REGION)-\(strings.ToLower(format)).pkg.dev/\(PROJECT)/\(id)"
}

resource: google_artifact_registry_repository: {for _id, _ar in _artifact_registry {
	"\(_id)": {
		repository_id: _ar.id
		description:   _ar.description
		format:        _ar.format
		location:      _ar.location
	}
}}

resouce: google_artifact_registry_repository_iam_policy: {for _id, _ar in _artifact_registry {
	"\(_id)": _#Policy & {
		location:   _ar.location
		repository: "projects/\(PROJECT)/locations/\(_ar.location)/repositories/\(_ar.id)"
		_policy:    _ar.policy
	}
}}
