package infra

PROJECT: "com-seankhliao"
REGION:  "us-central1"

terraform: required_providers: "google": {
	source:  "hashicorp/google-beta"
	version: "4.23.0"
}

provider: "google": {
	project: PROJECT
	region:  REGION
	zone:    "\(REGION)-a"
}

default_compute_serviceaccount:    "330311169810-compute@developer.gserviceaccount.com"
default_cloudbuild_serviceaccount: "330311169810@cloudbuild.gserviceaccount.com"
