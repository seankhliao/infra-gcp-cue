package infra

_cloudbuild_trigger_github: vanity: repo: "vanity"

_service_account: go_seankhliao_com: {
	id:          "go-seankhliao-com"
	name:        "go.seankhliao.com"
	description: "Cloud Run service account for go.seankhliao.com"
}

_cloudrun_service: go_seankhliao_com: {
	name:            "go-seankhliao-com"
	image:           "\(_artifact_registry.run.url)/vanity:latest"
	proto:           "h2c"
	service_account: _service_account.go_seankhliao_com.email
	policy: "roles/run.invoker": ["allUsers"]
	domain: ["go.seankhliao.com"]
}
