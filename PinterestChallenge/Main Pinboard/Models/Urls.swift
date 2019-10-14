//
//  Urls.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct Urls : Mappable {
	var raw : String?
	var full : String?
	var regular : String?
	var small : String?
	var thumb : String?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		raw <- map["raw"]
		full <- map["full"]
		regular <- map["regular"]
		small <- map["small"]
		thumb <- map["thumb"]
	}

}
