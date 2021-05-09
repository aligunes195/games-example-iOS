//
//  MainTabBarController.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    var selectedScene: MainScene {
        guard let scene = MainScene(rawValue: self.selectedIndex) else {
            fatalError("MainTabBarController: MainScene has wrong value")
        }
        return scene
    }
    
    func changeScene(_ scene: MainScene) {
        self.selectedIndex = scene.rawValue
    }
}
