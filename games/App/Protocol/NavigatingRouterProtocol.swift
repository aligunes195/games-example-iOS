//
//  NavigatingRouterProtocol.swift
//  games
//
//  Created by ali güneş on 13.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

protocol NavigatingRouterProtocol: RouterProtocol {
    var navController: UINavigationController { get }
}
