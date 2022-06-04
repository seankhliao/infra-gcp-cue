package infra

_service_account: lilith: {
	id:          "lilith"
	name:        "Lilith"
	description: "service account for the lilith vm"
}

_compute_instance: lilith: {
	name:            "lilith"
	ipv4_ptr:        "lilith.liao.dev."
	ipv6_ptr:        "lilith.liao.dev."
	service_account: _service_account.lilith.email
	tags: ["https", "wg"]
}
