//
//  GamePresentation.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class GamePresentation {
    private let game: Game
    
    let clickedBefore: Bool
    
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
        return game.imageData
    }
    
    init(_ game: Game,
         clickedBefore: Bool) {
        self.game = game
        self.clickedBefore = clickedBefore
    }
}
