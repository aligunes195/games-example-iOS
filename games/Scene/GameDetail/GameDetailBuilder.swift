//
//  GameDetailBuilder.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class GameDetailBuilder {
    static func build(game: Game) -> GameDetailVC {
        let vc = UIStoryboard.load(.gameDetail) as! GameDetailVC
        vc.vm = GameDetailVM(game: game)
        return vc
    }
}
