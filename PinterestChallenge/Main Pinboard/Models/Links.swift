//
//  Links.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct Links : Mappable {
	var self_link : String?
	var html : String?
	var download : String?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		self_link <- map["self"]
		html <- map["html"]
		download <- map["download"]
	}

}
