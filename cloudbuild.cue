package infra

import (
	"strings"
)

_cloudbuild_trigger_github: [string]: #CloudBuildGithub
#CloudBuildGithub: {
	repo:     string
	filename: string | *"cloudbuild.yaml"
	push:     _ | *{branch: "^main$"}
}

_cloudbuild_trigger_schedule: [string]: #CloudBuildSchedule
#CloudBuildSchedule: {
	repo:     string
	filename: string | *"cloudbuild.yaml"
	rev:      _ | *"refs/heads/main"
}

resource: google_cloudbuild_trigger: {
	for _id, _cb in _cloudbuild_trigger_github {
		"\(_id)": {
			let _name = strings.Replace(_cb.repo, ".", "-", -1)
			name:     _name
			filename: _cb.filename
			github: [{
				owner: "seankhliao"
				name:  _cb.repo
				push: [_cb.push]
			}]
		}
	}
	for _id, _cb in _cloudbuild_trigger_schedule {
		"\(_id)": {
			let _name = strings.Replace(_cb.repo, ".", "-", -1)
			name: _name
			git_file_source: [{
				path:      _cb.filename
				repo_type: "GITHUB"
				revision:  _cb.rev
				uri:       "https://github.com/seankhliao/\(_cb.repo)"
			}]
			source_to_build: [{
				ref:       _cb.rev
				repo_type: "GITHUB"
				uri:       "https://github.com/seankhliao/\(_cb.repo)"
			}]
		}
	}
}
