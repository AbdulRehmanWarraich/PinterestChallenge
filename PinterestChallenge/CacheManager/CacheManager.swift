//
//  CacheManager.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import Foundation

class CacheManager {
    static let shared = CacheManager(configs: CacheConfigs())
    
    private var configs: CacheConfigs
    private var cached = [String : CachedItem]()
    private var timer : Timer?
    
    init(configs: CacheConfigs) {
        
        self.configs = configs
        
        startTimer(withTimeInterval: configs.cleanUpPeriod)
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
    
    func validateCacheSize(after duration:TimeInterval) {
        configs.cleanUpPeriod = duration
        
        startTimer(withTimeInterval: configs.cleanUpPeriod)
    }
    
    func updateMaxLimt(_ limit :Int) {
        configs.maxItems = limit
    }
    
    private func releaseResources() {
        if cached.count > configs.maxItems {
            
            let sorted = cached.sorted(by: {($0.value.requestedTimes,$0.value.createdTime) > ($1.value.requestedTimes,$1.value.createdTime)})
            
            for i in configs.maxItems..<sorted.count {
                cached.removeValue(forKey: sorted[i].key)
            }
        }
    }
    
    private func startTimer(withTimeInterval timeInterval : TimeInterval) {
        timer?.invalidate()
        if configs.cleanUpPeriod > 0 {
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
                print("Clearing function called")
                self.releaseResources()
            }
        }
    }
    
}

