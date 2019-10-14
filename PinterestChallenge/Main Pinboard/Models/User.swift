//
//  User.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct User : Mappable {
	var id : String?
	var username : String?
	var name : String?
	var profile_image : ProfileImage?
	var links : Links?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		id <- map["id"]
		username <- map["username"]
		name <- map["name"]
		profile_image <- map["profile_image"]
		links <- map["links"]
	}

}
