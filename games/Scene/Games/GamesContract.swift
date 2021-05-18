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
    var query: String { get set }
    
    func load()
    func loadMore(completion: (() -> Void)?)
    
    func numberOfGames() -> Int
    func getGame(at indexPath: IndexPath) -> GamePresentation
    func selectGame(at indexPath: IndexPath)
}

protocol GamesVMOutputDelegate: class {
    func isVisible(id: Int) -> Bool
    func reloadData(rows: [Int]?)
    func insertData(rows: [Int])
}

protocol GamesNavigationDelegate: class {
    func showDetail(with id: Int)
}
