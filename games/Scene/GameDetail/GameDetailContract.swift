//
//  GameDetailContracts.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

protocol GameDetailVMProtocol: AnyObject {
    var delegate: GameDetailVMOutputDelegate? { get set }
    
    func load()
    func toggleFavourite()
}

protocol GameDetailVMOutputDelegate: AnyObject {
    func updateGamePresentation(_ gamePresentation: GameDetailPresentation)
}
