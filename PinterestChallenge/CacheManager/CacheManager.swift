//
//  CacheManager.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import Foundation

class CacheManager {
    static let shared = CacheManager(configs: CacheConfigs.default())

    var configs: CacheConfigs
    private var cached = [String : CachedItem]()
    var maxItemsCount: Int

    init(configs: CacheConfigs) {

        self.configs = configs
        self.maxItemsCount = configs.maxItems

        if configs.cleanUpPeriod != 0 {
            Timer.scheduledTimer(withTimeInterval: configs.cleanUpPeriod, repeats: true) { (timer) in
                self.releaseResources()
            }
        }
    }

    func set(url: String, item: Data) {
        var cachedItem = cached[url]
        if cachedItem == nil {
            cachedItem = CachedItem(url: url, item: item)
            cached[url] = cachedItem
        }
    }

    func getItem(url: String) -> Data? {
        return cached[url]?.getItem()
    }

    func releaseResources() {
        if cached.count == configs.maxItems {

            var leastRequestedKey: String?
            var leastRequestedTimes: Int = Int.max
            for itemKey in cached.keys {
                if let cacheditem = cached[itemKey] {
                    if cacheditem.requestedTimes < leastRequestedTimes {
                        leastRequestedKey = itemKey
                        leastRequestedTimes = cacheditem.requestedTimes
                    }
                }
            }

            if leastRequestedKey != nil {
                cached.removeValue(forKey: leastRequestedKey!)
            }
        }
    }
}

