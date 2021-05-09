//
//  FavouritesRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesRouter: NavigatingRouterProtocol {
    var rootVC: UIViewController
    var navController: UINavigationController
    
    init() {
        rootVC = FavouritesBuilder.build()
        navController = UINavigationController(rootViewController: rootVC)
        navController.view.backgroundColor = .white
        navController.tabBarItem = UITabBarItem(title: String.localized("FAVOURITES_TITLE"),
                                                image: UIImage(named: "favourite-icon"),
                                                selectedImage: UIImage(named: "favourite-icon"))
        navController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {}
}
