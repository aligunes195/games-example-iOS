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
    
    var appGroupIdentifier: String {
        return "group.com.alig.games"
    }
    
    var appGroupContainerURL: URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
            fatalError("App Group Container URL not found")
        }
        return url
    }
    
    var imagesURL: URL {
        let url = appGroupContainerURL.appendingPathComponent("images")
        
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        
        return url
    }
    
    var thumbnailsURL: URL {
        let url = appGroupContainerURL.appendingPathComponent("thumbnails")
        
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        
        return url
    }
}
