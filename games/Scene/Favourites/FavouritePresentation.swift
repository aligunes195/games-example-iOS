//
//  FavouritePresentation.swift
//  games
//
//  Created by ali güneş on 21.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class FavouritePresentation {
    private let game: Game
    
    var id: Int {
        return game.id
    }
    
    var name: String {
        return game.name
    }
    
    var metacritic: Int? {
        return game.metacritic
    }
    
    var genres: [String] {
        return game.genres
    }
    
    var hasImage: Bool {
        return game.imageUrl != nil
    }
    
    var imageData: DataWrapper? {
        return game.thumbnailData
    }
    
    init(_ game: Game) {
        self.game = game
    }
}
