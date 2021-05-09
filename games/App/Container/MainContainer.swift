//
//  MainConfiguration.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

final class MainContainer: ContainerProtocol {
    let networkManager: NetworkManager
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    func load() {}
    
    func unload() {}
    
    func buildRouter() -> RouterProtocol {
        return MainRouter()
    }
}
