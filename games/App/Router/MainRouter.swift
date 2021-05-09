//
//  MainRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class MainRouter: RouterProtocol {
    var rootVC: UIViewController
    
    private let childRouters: [MainScene: NavigatingRouterProtocol]
    
    init() {
        childRouters = [
            .games : GamesRouter(),
            .favourites : FavouritesRouter()
        ]
        
        let tabBarController = MainTabBarController()
        tabBarController.viewControllers = childRouters
            .sorted(by: { $0.key.rawValue < $1.key.rawValue })
            .map { $0.value.navController }
        tabBarController.changeScene(.games)
        rootVC = tabBarController
    }
    
    func start() {
        app.window.rootViewController = rootVC
    }
}
