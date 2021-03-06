package infra

_clouddns_zone: liao_dev: {
	name:        "liao-dev"
	description: "liao.dev"
	dns:         "liao.dev."
	records: {
		"_dmarc": TXT: [
			"\"v=DMARC1; p=reject; rua=mailto:dmarc-reporting@liao.dev; adkim=s; aspf=s;\"",
		]
		"": {
			A: [
				"199.36.158.100",
			]
			MX: [
				"1 aspmx.l.google.com.",
				"5 alt1.aspmx.l.google.com.",
				"5 alt2.aspmx.l.google.com.",
				"10 alt3.aspmx.l.google.com.",
				"10 alt4.aspmx.l.google.com.",
			]
			TXT: [
				"google-site-verification=Hr-zEVjXXlyQRw6CpukHxPSxfBrqJk72352MejNIcn0",
				"\"v=spf1 include:_spf.google.com ~all\"",
			]
		}
		"earbug": CNAME: ["ghs.googlehosted.com."]
		"ghdefaults": CNAME: ["ghs.googlehosted.com."]
		"google._domainkey": TXT: [
			"\"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtxQ+Y/kQdVU4pwrAZk10LpfigSjyryLaDNt0Jq+JrBx2B3T5xzCdn1jFb7Q393jTnTREgGU00yorEZUZq3ChGwwTsmKiQCec6povJ/EBPLrh7OHW/7fUAM++ev/OQ4WD4dLXedvFhXKiZWh20nWZVz+PiAjKMJ+UZBTqE6R8tSRjqkJp38HLskB0sDkru8r1Y\" \"/MQbtPWIV+U8xupOAdfNvaOWGg06+I/gfG6T4ozHEcYrPj7X0Ju/szuVVNfUVU2fOgkke8ivWMMyVdkHzuAzn8bFOGSi+LwTdCs9IDBbY4zCtOhr61g+ysRL79l02z2ErFvJnmzAmGSQyNOLfAOtwIDAQAB\"",
		]
		"newtab": CNAME: ["ghs.googlehosted.com."]
		"paste": CNAME: ["ghs.googlehosted.com."]
		"seankhliao.com._report._dmarc": TXT: [
			"\"v=DMARC1;\"",
		]
	}
}

_clouddns_zone: seankhliao_com: {
	name:        "seankhliao-com"
	description: "seankhliao.com"
	dns:         "seankhliao.com."
	records: {
		"_dmarc": TXT: [
			"\"v=DMARC1; p=reject; rua=mailto:dmarc-reporting@liao.dev; adkim=s; aspf=s\"",
		]
		"": {
			A: [
				"199.36.158.100",
			]
			MX: [
				"1 aspmx.l.google.com.",
				"5 alt1.aspmx.l.google.com.",
				"5 alt2.aspmx.l.google.com.",
				"10 alt3.aspmx.l.google.com.",
				"10 alt4.aspmx.l.google.com.",
			]
			TXT: [
				"google-site-verification=PcA6ADCwVhvsPmq1x3tHWX9IqDw_D6kPi3_dYOHDX7M",
				"v=spf1 include:_spf.google.com ~all",
			]
		}
		go: CNAME: [
			"ghs.googlehosted.com.",
		]
		"google._domainkey": TXT: [
			"\"v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtxQ+Y/kQdVU4pwrAZk10LpfigSjyryLaDNt0Jq+JrBx2B3T5xzCdn1jFb7Q393jTnTREgGU00yorEZUZq3ChGwwTsmKiQCec6povJ/EBPLrh7OHW/7fUAM++ev/OQ4WD4dLXedvFhXKiZWh20nWZVz+PiAjKMJ+UZBTqE6R8tSRjqkJp38HLskB0sDkru8r1Y\" \"/MQbtPWIV+U8xupOAdfNvaOWGg06+I/gfG6T4ozHEcYrPj7X0Ju/szuVVNfUVU2fOgkke8ivWMMyVdkHzuAzn8bFOGSi+LwTdCs9IDBbY4zCtOhr61g+ysRL79l02z2ErFvJnmzAmGSQyNOLfAOtwIDAQAB\"",
		]
	}
}
