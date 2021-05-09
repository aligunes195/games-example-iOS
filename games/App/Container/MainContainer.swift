//
//  MainConfiguration.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

final class MainContainer: ContainerProtocol {
    func load() {
        
    }
    
    func unload() {
        
    }
    
    func buildRouter() -> RouterProtocol {
        return MainRouter()
    }
}
