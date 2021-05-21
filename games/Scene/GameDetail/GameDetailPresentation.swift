//
//  GameDetailPresentation.swift
//  games
//
//  Created by ali güneş on 21.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class GameDetailPresentation {
    private let game: Game
    
    var imageData: DataWrapper? {
        return game.imageData ?? game.thumbnailData
    }
    
    var name: String {
        return game.name
    }
    
    var description: String? {
        return game.detail?.description
    }
    
    var redditUrl: String? {
        return game.detail?.redditUrl
    }
    
    var websiteUrl: String? {
        return game.detail?.websiteUrl
    }
    
    init(_ game: Game) {
        self.game = game
    }
}
