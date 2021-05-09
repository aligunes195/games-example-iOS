//
//  FavouritesBuilder.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class FavouritesBuilder {
    static func build() -> FavouritesVC {
        let vc = FavouritesVC()
        vc.vm = FavouritesVM()
        return vc
    }
}
