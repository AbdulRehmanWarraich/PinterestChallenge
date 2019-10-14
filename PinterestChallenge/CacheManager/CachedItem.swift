//
//  CachedItem.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import Foundation

class CachedItem {
    private let url: String
    private let item: Data

    private(set) public var createdTime: Date
    private(set) public var requestedTimes: Int = 0

    init(url: String, item: Data) {
        self.url = url
        self.item = item
        self.createdTime = Date()
    }

    func getItem() -> Data{
        requestedTimes += 1
        return item
    }

}
