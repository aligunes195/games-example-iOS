//
//  SearchRouter.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class SearchRouter: NavigatingRouterProtocol {
    var rootVC: UIViewController
    var navController: UINavigationController
    
    init() {
        rootVC = SearchBuilder.build()
        navController = UINavigationController(rootViewController: rootVC)
        navController.view.backgroundColor = .white
        navController.tabBarItem = UITabBarItem(title: String.localized("SEARCH_TITLE"),
                                                image: UIImage(named: "search-icon"),
                                                selectedImage: UIImage(named: "search-icon-selected"))
        navController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {}
}
