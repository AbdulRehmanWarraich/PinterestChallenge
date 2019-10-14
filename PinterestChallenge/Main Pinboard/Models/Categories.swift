//
//  Categories.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct Categories : Mappable {
	var id : Int?
	var title : String?
	var photo_count : Int?
	var links : Links?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		id <- map["id"]
		title <- map["title"]
		photo_count <- map["photo_count"]
		links <- map["links"]
	}

}
