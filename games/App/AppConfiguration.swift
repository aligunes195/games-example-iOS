//
//  AppConfiguration.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    private init() {}
    
    let baseUrl = "https://api.rawg.io"
    let apiKey = "5f3f08b28e8745b599aed7512634c491"
    
    var bundleIdentifier: String {
        guard let id = Bundle.main.bundleIdentifier else {
            fatalError("Bundle Identifier not found")
        }
        return id
    }
    
    var appGroupContainerURL: URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.alig.games") else {
            fatalError("App Group Container URL not found")
        }
        return url
    }
    
    var cachedImagesURL: URL {
        let url = appGroupContainerURL.appendingPathComponent("cachedImages")
        
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        
        return url
    }
    
    var cachedThumbnailsURL: URL {
        let url = appGroupContainerURL.appendingPathComponent("cachedThumbnails")
        
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        
        return url
    }
}
