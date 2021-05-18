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
    let clickedBefore: Bool
    
    var imageData: DataWrapper?
    
    init(dto: SearchResponseDTO,
         clickedBefore: Bool,
         imageData: DataWrapper?) {
        self.id = dto.id
        self.name = dto.name
        self.metacritic = dto.metacritic
        self.imageUrl = dto.background_image
        self.genres = dto.genres.map { $0.name }
        self.clickedBefore = clickedBefore
        self.imageData = imageData
    }
}
