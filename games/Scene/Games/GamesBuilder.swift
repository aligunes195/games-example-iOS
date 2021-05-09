//
//  GamesBuilder.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class GamesBuilder {
    static func build() -> GamesVC {
        let vc = UIStoryboard.load(.games) as! GamesVC
        vc.vm = GamesVM()
        return vc
    }
}
