package infra

import (
	"encoding/json"
)

_service_account: cosign_signer: {
	id:          "cosign-signer"
	name:        "Cosign Signer"
	description: "Service account for signing artifacts with cosign keyless flow"
	policy: "roles/iam.serviceAccountTokenCreator": [
		"serviceAccount:\(default_cloudbuild_serviceaccount)",
	]
}

// scheduled jobs

_service_account: cloud_build_trigger_scheduler: {
	id:          "cloud-build-trigger-scheduler"
	name:        "Cloud Build Trigger Scheduler"
	description: "Service account for running Cloud Build triggers in a Cloud Scheduler job"
}

_cloudscheduler_http: cloudbuild_nightly: {
	name:        "cloudbuild-nightly-schedule"
	description: "Run cloudbuild-nightly every day"
	schedule:    "0 4 * * *"
	uri:         "https://cloudbuild.googleapis.com/v1/projects/\(PROJECT)/triggers/${resource.google_cloud_build_trigger.cloudbuild_nightly.trigger_id}:run"
	headers: {
		"Content-Type": "application/octet-stream"
		"User-Agent":   "Google-Cloud-Scheduler"
	}
	body: json.Marshal({
		branchName: "main"
	})
	service_account: _service_account.cloud_build_trigger_scheduler.email
}

_cloudbuild_trigger_schedule: cloudbuild_nightly: repo: "cloudbuild-nightly"

// other git repos that only need a cloudbuild job

_cloudbuild_trigger_github: blogengine: repo:     "blogengine"
_cloudbuild_trigger_github: fin: repo:            "fin"
_cloudbuild_trigger_github: gchat: repo:          "gchat"
_cloudbuild_trigger_github: goreleases: repo:     "goreleases"
_cloudbuild_trigger_github: gosdkupdate: repo:    "gosdkupdate"
_cloudbuild_trigger_github: liao_dev: repo:       "liao.dev"
_cloudbuild_trigger_github: mirrorrank: repo:     "mirrorrank"
_cloudbuild_trigger_github: seankhliao_com: repo: "seankhliao.com"
_cloudbuild_trigger_github: svcrunner: repo:      "svcrunner"
_cloudbuild_trigger_github: t: repo:              "t"
_cloudbuild_trigger_github: webserve: repo:       "webserve"
_cloudbuild_trigger_github: webstyle: repo:       "webstyle"
