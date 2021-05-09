//
//  ConfigurationProtocol.swift
//  games
//
//  Created by ali güneş on 6.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

protocol ContainerProtocol: class {
    func load()
    func unload()
    
    func buildRouter() -> RouterProtocol
}
