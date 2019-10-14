//
//  ProfileImage.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct ProfileImage : Mappable {
	var small : String?
	var medium : String?
	var large : String?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		small <- map["small"]
		medium <- map["medium"]
		large <- map["large"]
	}

}
