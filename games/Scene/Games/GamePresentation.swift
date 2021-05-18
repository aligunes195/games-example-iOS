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
    
    var clickedBefore: Bool {
        return game.clickedBefore
    }
    
    var imageData: DataWrapper? {
        return game.imageData
    }
    
    init(_ game: Game) {
        self.game = game
    }
}
