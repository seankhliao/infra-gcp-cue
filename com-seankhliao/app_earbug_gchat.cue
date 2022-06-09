package infra

import (
	"encoding/json"
)

_cloudbuild_trigger_github: earbug_gchat: repo: "earbug-gchat"

_service_account: earbug_gchat: {
	id:          "earbug-gchat"
	description: "service identity for cloud run earbug-gchat"
}

_service_account: earbug_gchat_trigger: {
	id:          "earbug-gchat-trigger"
	description: "service identity triggering cloud run earbug-gchat"
}

_cloudrun_service: earbug_gchat: {
	name: "earbug-gchat"
	env: EARBUG_BUCKET:           "earbug-liao-dev"
	secret_env: EARBUG_GCHAT:     "earbug-gchat-webhook"
	secret_env: LOG_ERRORS_GCHAT: "earbug-gchat-errors-gchat"
	service_account: _service_account.earbug_gchat.email
	policy: "roles/run.invoker": ["serviceAccount:\(_service_account.earbug_gchat_trigger.email)"]
}

_cloudscheduler_http: earbug_gchat: {
	name:        "earbug-gchat"
	description: "Run earbug summary every day"
	schedule:    "5 0 * * *"
	uri:         "${resource.google_cloud_run_service.earbug_gchat.url}/summary"
	headers: {
		"Content-Type": "application/octet-stream"
		"User-Agent":   "Google-Cloud-Scheduler"
	}
	body: json.Marshal({
		user: "seankhliao"
	})
	service_account: _service_account.earbug_gchat_trigger.email
}
