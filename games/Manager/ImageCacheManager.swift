//
//  ImageCacheManager.swift
//  games
//
//  Created by Ali Güneş on 17.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class ImageCacheManager {
    private let thumbnailCache: NSCache<NSString, DataWrapper> = {
        let cache = NSCache<NSString, DataWrapper>()
        cache.countLimit = 1000
        return cache
    }()
    
    private let imageCache: NSCache<NSString, DataWrapper> = {
        let cache = NSCache<NSString, DataWrapper>()
        cache.countLimit = 50
        return cache
    }()
    
    func getThumbnail(with key: String) -> DataWrapper? {
        return thumbnailCache.object(forKey: key as NSString)
    }
    
    func getImage(with key: String) -> DataWrapper? {
        return imageCache.object(forKey: key as NSString)
    }
    
    func saveThumbnail(key: String, dataWrapper: DataWrapper) {
        thumbnailCache.setObject(dataWrapper, forKey: key as NSString)
    }
    
    func saveImage(key: String, dataWrapper: DataWrapper) {
        imageCache.setObject(dataWrapper, forKey: key as NSString)
    }
}
