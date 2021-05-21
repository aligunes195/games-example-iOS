//
//  FavouritesBuilder.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesBuilder {
    static func build() -> FavouritesVC {
        let vc = UIStoryboard.load(.favourites) as! FavouritesVC
        vc.vm = FavouritesVM()
        return vc
    }
}
