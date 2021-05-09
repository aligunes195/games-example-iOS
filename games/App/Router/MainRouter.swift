//
//  MainRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class MainRouter: RouterProtocol {
    lazy var rootVC: UIViewController = {
        let tabBarController = MainTabBarController()
        tabBarController.viewControllers = childRouters
            .sorted(by: { $0.key.rawValue < $1.key.rawValue })
            .map { $0.value.navController }
        tabBarController.changeScene(.games)
        return tabBarController
    }()
    
    private let childRouters: [MainScene: NavigatingRouterProtocol]
    
    init() {
        childRouters = [
            .games : GamesRouter(),
            .favourites : FavouritesRouter()
        ]
    }
    
    func start() {
        childRouters.values.forEach { $0.start() }
        app.window.rootViewController = self.rootVC
    }
}
