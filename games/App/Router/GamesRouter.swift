//
//  GamesRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class GamesRouter: NavigatingRouterProtocol {
    var rootVC: UIViewController
    var navController: UINavigationController
    
    init() {
        rootVC = GamesBuilder.build()
        navController = UINavigationController(rootViewController: rootVC)
        navController.view.backgroundColor = .white
        navController.tabBarItem = UITabBarItem(title: String.localized("GAMES_TITLE"),
                                                image: UIImage(named: "game-console-icon"),
                                                selectedImage: UIImage(named: "game-console-icon"))
        navController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {}
}
