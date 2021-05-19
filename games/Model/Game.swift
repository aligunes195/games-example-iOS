//
//  Game.swift
//  games
//
//  Created by Ali Güneş on 18.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class Game {
    let id: Int
    let name: String
    let metacritic: Int?
    let imageUrl: String?
    let genres: [String]
    
    var detail: GameDetail?
    var thumbnailData: DataWrapper?
    var imageData: DataWrapper?
    
    init(id: Int,
         name: String,
         metacritic: Int?,
         imageUrl: String?,
         genres: [String],
         detail: GameDetail? = nil,
         thumbnailData: DataWrapper? = nil,
         imageData: DataWrapper? = nil) {
        self.id = id
        self.name = name
        self.metacritic = metacritic
        self.imageUrl = imageUrl
        self.genres = genres
        self.detail = detail
        self.thumbnailData = thumbnailData
        self.imageData = imageData
    }
}
