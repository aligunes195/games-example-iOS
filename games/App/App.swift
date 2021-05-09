//
//  App.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

let app = App()

final class App {
    
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds) // Generic window
    
    var container: ContainerProtocol {
        didSet {
            oldValue.unload()
            self.container.load()
        }
    }
    lazy var router: RouterProtocol = self.container.buildRouter()
    
    init() {
        self.container = ContainerBuilder.build()
    }
    
    func start() {
        self.router.start()
        self.window.makeKeyAndVisible()
    }
}
