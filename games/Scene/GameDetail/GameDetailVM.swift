//
//  GameDetailVM.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class GameDetailVM: GameDetailVMProtocol {
    private let game: Game
    
    var imageDataWrapper: DataWrapper? {
        return game.imageData ?? game.thumbnailData
    }
    
    init(game: Game) {
        self.game = game
    }
    
    func load() {
        
    }
}
