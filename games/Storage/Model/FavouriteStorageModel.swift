//
//  FavouriteStorageModel.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class FavouriteStorageModel {
    let id: Int
    let name: String
    let metacritic: Int?
    let imageUrl: String?
    let genres: [String]
    let description: String
    let redditUrl: String?
    let websiteUrl: String?
    
    init(game: Game) {
        self.id = game.id
        self.name = game.name
        self.metacritic = game.metacritic
        self.imageUrl = game.imageUrl
        self.genres = game.genres
        self.description = game.detail?.description ?? ""
        self.redditUrl = game.detail?.redditUrl
        self.websiteUrl = game.detail?.websiteUrl
    }
}
