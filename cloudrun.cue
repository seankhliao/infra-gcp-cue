package infra

import (
	"strings"
)

_cloudrun_service: [string]: #CloudRunService
#CloudRunService: {
	name:  string
	image: string
	secret_env: [string]: string
	proto:           "h2c" | *"http1"
	cpu:             string | *"1000m"
	memory:          string | *"128Mi"
	timeout:         int | *5
	service_account: string
	policy:          #Policy | *[]
	domain:          [string] | *[]
}

resource: google_cloud_run_service: {for _id, _cr in _cloudrun_service {
	"\(_id)": {
		name:     _cr.name
		location: REGION

		autogenerate_revision_name: true
		template: [{
			spec: [{
				containers: [{
					image: _cr.image
					env: [
						for _key, _secret in _cr.secret_env {
							name: _key
							value_from: [{
								secret_key_ref: [{
									name: _secret
									key:  "latest"
								}]
							}]
						},
					]
					ports: [{
						name:           _cr.proto
						container_port: 8080
					}]
					resources: [{
						limits: {
							cpu:    _cr.cpu
							memory: _cr.memory
						}
					}]
				}]
				timeout_seconds:      _cr.timeout
				service_account_name: _cr.service_account
			}]
		}]
		lifecycle: [{
			ignore_changes: [
				"template[0].spec[0].containers[0].image",
			]
		}]
	}
}}

resource: google_cloud_run_service_iam_policy: {for _id, _cr in _cloudrun_service {
	"\(_id)": _#Policy & {
		location: REGION
		service:  _cr.name
		_policy:  _cr.policy
	}
}}

resource: google_cloud_run_domain_mapping: {for _id, _cr in _cloudrun_service {
	for _domain in _cr.domain {
		_name: strings.Replace(_domain, ".", "_", -1)
		"\(_name)": {
			location: REGION
			name:     _domain
			metadata: namespace: PROJECT
			spec: route_name:    _cr.name
		}
	}
}}
