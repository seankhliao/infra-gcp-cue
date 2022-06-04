package infra

_pubsub_topic: cloud_builds: {
	name: "cloud-builds"
}

_service_account: cloudrun_pubsub_invoker: {
	id:          "cloudrun-pubsub-invoker"
	name:        "Cloud Run Pub/Sub Invoker"
	description: "Service account for invoking Cloud Run when it receives a message"
}
