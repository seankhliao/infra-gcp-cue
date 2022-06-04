package infra

_compute_instance: [string]: #ComputeInstance
#ComputeInstance: {
	name:            string
	service_account: string
	description:     string | *""
	machine:         string | *"e2-micro"
	zone:            string | *"\(REGION)-a"
	boot_size:       int | *100
	boot_image:      string | *"projects/arch-linux-gce/global/images/family/arch"
	network:         string | *"default"
	subnetwork:      string | *REGION
	ipv4_ptr?:       string
	ipv6_ptr?:       string
	tags: [...string]
}

resource: google_compute_instance: {for _id, _ci in _compute_instance {
	"\(_id)": {
		boot_disk: [{
			initialize_params: [{
				size: _ci.boot_size
			}]
		}]
		machine_type: _ci.machine
		name:         _ci.name
		zone:         _ci.zone
		tags:         _ci.tags
		network_interface: [{
			network:    _ci.network
			subnetwork: _ci.subnetwork
			stack_type: "IPV4_IPV6"
			if _ci.ipv4_ptr != _|_ {
				access_config: [{
					public_ptr_domain_name: _ci.ipv4_ptr
				}]
			}
			if _ci.ipv6_ptr != _|_ {
				ipv6_access_config: [{
					public_ptr_domain_name: _ci.ipv4_ptr
					network_tier:           "PREMIUM"
				}]
			}
		}]
		can_ip_forward: true
		description:    _ci.description
		service_account: [{
			email: _ci.service_account
			scopes: ["cloud-platform"]
		}]
		shielded_instance_config: [{
			enable_integrity_monitoring: true
			enable_secure_boot:          false
			enable_vtpm:                 true
		}]
	}
}}
