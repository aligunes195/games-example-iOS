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
    
    init(dto: DetailResponseDTO) {
        self.id = dto.id
        self.description = dto.description_raw ?? ""
        self.websiteUrl = dto.website
        self.redditUrl = dto.reddit_url
    }
}
