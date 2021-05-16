//
//  GamesContract.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

protocol GamesVMProtocol: class {
    var delegate: GamesVMOutputDelegate? { get set }
    var items: [GamePresentation] { get }
    
    func load()
}

protocol GamesVMOutputDelegate: class {
    func reloadData(rows: [Int]?)
}

protocol GamesNavigationDelegate: class {
    func showDetail(with id: Int)
}
