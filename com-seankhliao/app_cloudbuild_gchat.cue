package infra

_cloudbuild_trigger_github: cloudbuild_gchat: repo: "cloudbuild-gchat"

_pubsub_topic: cloud_builds: pushes: cloudbuild_gchat: {
	name:            "cloud-builds-gchat"
	endpoint:        "${resource.google_cloud_run_service.cloudbuild_gchat.status[0].url}"
	service_account: _service_account.cloudrun_pubsub_invoker.email
}

_service_account: cloudbuild_gchat: {
	id:          "cloudbuild-gchat"
	description: "service identity for cloud run cloudbuild-gchat"
}

_cloudrun_service: cloudbuild_gchat: {
	name:  "cloudbuild-gchat"
	image: "\(_artifact_registry.run.url)/cloudbuild-gchat:latest"
	proto: "h2c"
	secret_env: GCHAT_WEBHOOK: "cloudbuild-gchat-webhook"
	service_account: _service_account.cloudbuild_gchat.email
}
