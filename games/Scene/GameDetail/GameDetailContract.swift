//
//  GameDetailContracts.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

protocol GameDetailVMProtocol: class {
    var imageDataWrapper: DataWrapper? { get }
    
    func load()
}
