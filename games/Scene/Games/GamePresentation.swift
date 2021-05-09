//
//  GamePresentation.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

struct GamePresentation {
    let id: Int
    let name: String
    let metacritic: Int?
    let genres: [String]
    let clickedBefore: Bool
    
    var imageUrl: String?
}
