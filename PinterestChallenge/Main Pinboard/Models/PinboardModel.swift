//
//  PinboardModel.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import ObjectMapper

struct PinboardModel : Mappable {
	var id : String?
	var created_at : String?
	var width : Int?
	var height : Int?
	var color : String?
	var likes : Int?
	var liked_by_user : Bool?
	var user : User?
	var current_user_collections : [String]?
	var urls : Urls?
	var categories : [Categories]?
	var links : Links?

	init?(map: Map) {}

	mutating func mapping(map: Map) {

		id <- map["id"]
		created_at <- map["created_at"]
		width <- map["width"]
		height <- map["height"]
		color <- map["color"]
		likes <- map["likes"]
		liked_by_user <- map["liked_by_user"]
		user <- map["user"]
		current_user_collections <- map["current_user_collections"]
		urls <- map["urls"]
		categories <- map["categories"]
		links <- map["links"]
	}

}
