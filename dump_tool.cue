package infra

import (
	"encoding/json"
	"tool/cli"
)

command: dump: {
	task: print: cli.Print & {
		text: json.Indent(json.Marshal({
			"provider":  provider
			"resource":  resource
			"terraform": terraform
		}), "", "  ")
	}
}
