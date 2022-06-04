package infra

_service_account: [string]: #ServiceAccount
#ServiceAccount: {
	id: string
	// optional values
	name:        string | *id
	description: string | *""
	policy:      #Policy | *[]
	project:     string | *PROJECT
	// computed values
	email: "\(id)@\(project).iam.gserviceaccount.com"
	uri:   "projects/\(project)/serviceAccounts/\(email)"
}

resource: google_service_account: {
	for _id, _sa in _service_account {
		"\(_id)": {
			account_id:   _sa.id
			display_name: _sa.name
			description:  _sa.description
		}
	}
}

resource: google_service_account_iam_policy: {
	for _id, _sa in _service_account {
		"\(_id)": _#Policy & {
			service_account_id: _sa.uri
			_policy:            _sa.policy
		}
	}
}
