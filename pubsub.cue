package infra

_pubsub_topic: [string]: #PubSubTopic
#PubSubTopic: {
	name: string
	pushes: [string]: #PubSubPush
	policy: #Policy | *[]
}

#PubSubPush: {
	name:             string
	endpoint:         string
	service_account?: string
	policy:           #Policy | *[]
}

resource: google_pubsub_topic: {for _id, _top in _pubsub_topic {
	"\(_id)": {
		name: _top.name
	}
}}

resource: google_pubsub_topic_iam_policy: {for _id, _top in _pubsub_topic {
	"\(_id)": _#Policy & {
		topic:   _top.name
		_policy: _top.policy
	}
}}

resource: google_pubsub_subscription: {for _id, _top in _pubsub_topic {
	for _subid, _sub in _top.pushes {
		"\(_subid)": {
			name:  _sub.name
			topic: _top.name
			push_config: [{
				push_endpoint: _sub.endpoint
				if _sub.service_account != _|_ {
					oidc_token: [{
						service_account_email: _sub.service_account
					}]
				}
			}]
			retry_policy: [{
				maximum_backoff: "600s"
				minimum_backoff: "10s"
			}]
		}
	}
}}

resource: google_pubsub_subscription_iam_policy: {for _id, _top in _pubsub_topic {
	for _subid, _sub in _top.pushes {
		"\(_subid)": _#Policy & {
			subscription: _sub.name
			_policy:      _sub.policy
		}
	}
}}
