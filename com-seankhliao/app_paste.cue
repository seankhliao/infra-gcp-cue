package infra

_cloudbuild_trigger_github: paste: repo: "paste"

_service_account: paste: {
	id:          "paste-liao-dev"
	name:        "paste"
	description: "pastebin service"
}

_cloudrun_service: paste: {
	name:  "paste-liao-dev"
	image: "\(_artifact_registry.run.url)/paste:latest"
	env: PASTE_BUCKET:            "paste-liao-dev"
	env: LOG_VERBOSITY:           "1"
	secret_env: LOG_ERRORS_GCHAT: "paste-errors-gchat"
	service_account: _service_account.paste.email
	proto:           "h2c"
	timeout:         300
	policy: "roles/run.invoker": ["allUsers"]
	domain: ["paste.liao.dev"]
}
