package infra

import (
	"encoding/json"
	"tool/file"
)

command: write: {
	task: write: file.Create & {
		filename: "config.tf.json"
		contents: json.Indent(json.Marshal({
			"provider":  provider
			"resource":  resource
			"terraform": terraform
		}), "", "  ")
	}
}
