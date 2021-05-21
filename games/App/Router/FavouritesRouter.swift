//
//  FavouritesRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesRouter: NavigatingRouterProtocol {
    let navController: UINavigationController
    
    lazy var rootVC: UIViewController = FavouritesBuilder.build()
    
    init() {
        navController = UINavigationController()
        navController.view.backgroundColor = .white
        navController.tabBarItem = UITabBarItem(title: String.localized("FAVOURITES_TITLE"),
                                                image: UIImage(named: "favourite-icon"),
                                                selectedImage: UIImage(named: "favourite-icon"))
        navController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        (rootVC as? FavouritesVC)?.routerDelegate = self
        navController.setViewControllers([rootVC], animated: false)
    }
}

extension FavouritesRouter: FavouritesNavigationDelegate {
    func showDetail(with game: Game) {
        let vc = GameDetailBuilder.build(game: game)
        navController.pushViewController(vc, animated: true)
    }
}
