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
}
