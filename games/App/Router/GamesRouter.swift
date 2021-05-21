//
//  GamesRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class GamesRouter: NavigatingRouterProtocol {
    let navController: UINavigationController
    
    lazy var rootVC: UIViewController = GamesBuilder.build()
    
    init() {
        navController = UINavigationController()
        navController.view.backgroundColor = .white
        navController.tabBarItem = UITabBarItem(title: String.localized("GAMES_TITLE"),
                                                image: UIImage(named: "game-console-icon"),
                                                selectedImage: UIImage(named: "game-console-icon"))
        navController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        (rootVC as? GamesVC)?.routerDelegate = self
        navController.setViewControllers([rootVC], animated: false)
    }
}

extension GamesRouter: GamesNavigationDelegate {
    func showDetail(with game: Game) {
        let vc = GameDetailBuilder.build(game: game)
        navController.pushViewController(vc, animated: true)
    }
}
