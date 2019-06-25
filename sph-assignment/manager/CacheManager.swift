//
//  CacheManager.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

class CacheManager {
    
    enum Key: String {
        case FEED = "feed"
    }
    
    static let shared = CacheManager()
    private init() {}
    
    let cache = NSCache<NSString, Feed>()
    
    func addToCache(feed: Feed) {
        cache.setObject(feed, forKey: Key.FEED.rawValue as NSString)
    }
    
    func retrieveFromCache() -> Feed? {
        if let feed = cache.object(forKey: Key.FEED.rawValue as NSString) {
            return feed
        }
        return nil
    }
    
    func clear() {
        cache.removeObject(forKey: Key.FEED.rawValue as NSString)
    }
}
