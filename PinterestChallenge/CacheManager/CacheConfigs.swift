//
//  CacheConfigs.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import Foundation

class CacheConfigs {
    var maxItems: Int = 50
    var cleanUpPeriod: TimeInterval = 5 * 60

    class func `default`() -> CacheConfigs {
        return CacheConfigs()
    }
}
