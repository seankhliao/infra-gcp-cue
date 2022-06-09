package infra

_cloudbuild_trigger_github: ghdefaults: repo: "ghdefaults"

_service_account: ghdefaults: {
	id:          "ghdefaults-liao-dev"
	name:        "ghdefaults"
	description: "github repo defaults"
}

_cloudrun_service: ghdefaults: {
	name:  "ghdefaults-liao-dev"
	image: "\(_artifact_registry.run.url)/ghdefaults:latest"
	env: GHDEFAULTS_APP_ID:                "126001"
	secret_env: GHDEFAULTS_PRIVATE_KEY:    "ghdefaults-private-key"
	secret_env: GHDEFAULTS_WEBHOOK_SECRET: "ghdefaults-webhook-secret"
	secret_env: LOG_ERRORS_GCHAT:          "ghdefaults-errors-gchat"
	proto:           "h2c"
	timeout:         300
	service_account: _service_account.ghdefaults.email
	policy: "roles/run.invoker": ["allUsers"]
	domain: ["ghdefaults.liao.dev"]
}
