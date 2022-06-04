package infra

import (
	"strings"
)

_clouddns_zone: [string]: #CloudDnsZone
#CloudDnsZone: {
	name:        string
	dns:         string
	description: string | *""
	visibility:  "private" | *"public"
	// subdomain: type: value
	records: [string]: [string]: [...string]
}

resource: google_dns_managed_zone: {for _id, _zone in _clouddns_zone {
	"\(_id)": {
		name:        _zone.name
		dns_name:    _zone.dns
		description: _zone.description
		visibility:  _zone.visibility

		dnssec_config: [{
			kind:          "dns#managedZoneDnsSecConfig"
			non_existence: "nsec3"
			state:         "on"

			default_key_specs: [{
				algorithm:  "ecdsap256sha256"
				key_length: 256
				key_type:   "keySigning"
			}, {
				algorithm:  "ecdsap256sha256"
				key_length: 256
				key_type:   "zoneSigning"
			}]
		}]
	}
}}

resource: google_dns_record_set: {for _id, _zone in _clouddns_zone {
	for _sub, _allrecs in _zone.records {
		for _type, _recs in _allrecs {
			let _rec_id = strings.Replace("\(_sub)__\(_id)__\(_type)", ".", "__", -1)
			"\(_rec_id)": {
				managed_zone: _zone.name
				if _sub != "" {
					name: "\(_sub).\(_zone.dns)"
				}
				if _sub == "" {
					name: _zone.dns
				}
				type:    _type
				ttl:     60
				rrdatas: _recs
			}
		}
	}
}}
