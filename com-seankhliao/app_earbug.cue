package infra

import (
	"encoding/json"
)

_cloudbuild_trigger_github: earbug: repo: "earbug"

_service_account: earbug: {
	id:          "earbug-liao-dev"
	description: "service identity for cloud run earbug"
}
_service_account: earbug_trigger: {
	id:          "earbug-trigger"
	description: "cloud scheduler identiy for triggering earbug"
}

_cloudrun_service: earbug: {
	name:  "earbug-liao-dev"
	image: "\(_artifact_registry.run.url)/earbug:latest"
	proto: "h2c"
	env: EARBUG_BUCKET:                "earbug-liao-dev"
	secret_env: EARBUG_SPOTIFY_ID:     "earbug-client-id"
	secret_env: EARBUG_SPOTIFY_SECRET: "earbug-client-secret"
	service_account: _service_account.earbug.email
	policy: "roles/run.invoker": ["allUsers"]
	domains: ["earbug.liao.dev"]
}

_cloudscheduler_http: earbug: {
	name:        "earbug"
	description: "Run earbug every 5 min"
	schedule:    "*/5 * * * *"
	uri:         "${resource.google_cloud_run_service.earbug.url}"
	headers: {
		"Content-Type": "application/octet-stream"
		"User-Agent":   "Google-Cloud-Scheduler"
	}
	body: json.Marshal({
		user: "seankhliao"
	})
	service_account: _service_account.earbug_trigger.email
}
