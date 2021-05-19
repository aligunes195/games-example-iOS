//
//  GameDetail.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class GameDetail {
    let id: Int
    let description: String
    let redditUrl: String?
    let websiteUrl: String?
    
    init(id: Int,
         description: String,
         redditUrl: String?,
         websiteUrl: String?) {
        self.id = id
        self.description = description
        self.websiteUrl = websiteUrl
        self.redditUrl = redditUrl
    }
}
