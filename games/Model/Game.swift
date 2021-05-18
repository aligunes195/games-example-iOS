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
    
    init(dto: SearchResponseDTO,
         detail: GameDetail? = nil,
         thumbnailData: DataWrapper? = nil,
         imageData: DataWrapper? = nil) {
        self.id = dto.id
        self.name = dto.name
        self.metacritic = dto.metacritic
        self.imageUrl = dto.background_image
        self.genres = dto.genres.map { $0.name }
        self.imageData = imageData
    }
}
