package infra

import (
	"strings"
)

_cloudrun_service: [string]: #CloudRunService
#CloudRunService: {
	name:  string
	image: string | *"\(_artifact_registry.run.url)/\(name):latest"
	// ENV_NAME: secret-name
	secret_env: [string]: string
	// /mount/dir: secret-name
	secret_mount: [string]: string
	// ENV_NAME: ENV_VALUE
	env: [string]: string
	proto:           *"h2c" | "http1"
	cpu:             string | *"1000m"
	memory:          string | *"128Mi"
	timeout:         int | *5
	service_account: string
	policy:          #Policy | *[]
	domain:          [string] | *[]
}

resource: google_cloud_run_service: {
	for _id, _cr in _cloudrun_service {
		"\(_id)": {
			name:     _cr.name
			location: REGION

			autogenerate_revision_name: true
			template: [{
				metadata: [{
					annotations: {
						"autoscaling.knative.dev/maxScale": "1"
					}
				}]
				spec: [{
					containers: [{
						image: _cr.image
						env: [
							{
								name:  "LOG_FORMAT"
								value: "json+gcp"
							},
							for _name, _secret in _cr.secret_env {
								name: _name
								value_from: [{
									secret_key_ref: [{
										name: _secret
										key:  "latest"
									}]
								}]
							},
							for _name, _value in _cr.env {
								name:  _name
								value: _value
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
						volume_mounts: [
							for _dir, _secret in _cr.secret_mount {
								name:       _secret
								mount_path: _dir
							},
						]
					}]
					timeout_seconds:      _cr.timeout
					service_account_name: _cr.service_account
					volumes: [
						for _dir, _secret in _cr.secret_mount {
							name: _secret
							secret: [{
								secret_name: _secret
							}]
						},
					]
				}]
			}]
			lifecycle: [{
				ignore_changes: [
					"template[0].spec[0].containers[0].image",
					"template[0].metadata[0].annotations[\"client.knative.dev/user-image\"]",
					"template[0].metadata[0].annotations[\"run.googleapis.com/client-name\"]",
					"template[0].metadata[0].annotations[\"run.googleapis.com/client-version\"]",
				]
			}]
		}
	}
}

resource: google_cloud_run_service_iam_policy: {
	for _id, _cr in _cloudrun_service {
		"\(_id)": _#Policy & {
			location: REGION
			service:  _cr.name
			_policy:  _cr.policy
		}
	}
}

resource: google_cloud_run_domain_mapping: {
	for _id, _cr in _cloudrun_service {
		for _domain in _cr.domain {
			let _name = strings.Replace(_domain, ".", "_", -1)
			"\(_name)": {
				location: REGION
				name:     _domain
				metadata: namespace: PROJECT
				spec: route_name:    _cr.name
			}
		}
	}
}
