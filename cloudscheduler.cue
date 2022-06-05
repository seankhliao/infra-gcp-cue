package infra

_cloudscheduler_http: [string]: #CloudSchedulerHttp
#CloudSchedulerHttp: {
	name:        string
	description: string | *""
	schedule:    string
	timezone:    string | *"Global/UTC"
	uri:         string
	method:      string | *"POST"
	headers?: [string]: string
	body?:            string
	service_account?: string
}

// resource: google_cloud_scheduler_job: {
//  for _id, _cs in _cloudscheduler_http {
//   "\(_id)": {
//    name:        _cs.name
//    description: _cs.description
//    schedule:    _cs.schedule
//    time_zone:   _cs.timezone
//    http_target: [{
//     uri:    _cs.uri
//     method: _cs.method
//     if _cs.headers != _|_ {
//      headers: _cs.headers
//     }
//     if _cs.body != _|_ {
//      body: _cs.body
//     }
//     if _cs.service_account != _|_ {
//      oauth_token: [{
//       service_account_email: _cs.service_account
//      }]
//     }
//    }]
//   }
//  }
// }
