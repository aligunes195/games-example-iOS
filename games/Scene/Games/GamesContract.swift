//
//  GamesContract.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

protocol GamesVMProtocol: AnyObject {
    var delegate: GamesVMOutputDelegate? { get set }
    var query: String { get set }
    
    func load()
    func loadMore(completion: (() -> Void)?)
    
    func numberOfGames() -> Int
    func getGamePresentation(at indexPath: IndexPath) -> GamePresentation
    func selectGame(at indexPath: IndexPath)
    func getGame(at indexPath: IndexPath) -> Game
}

protocol GamesVMOutputDelegate: AnyObject {
    func isVisible(id: Int) -> Bool
    func reloadData(rows: [Int]?)
    func insertData(rows: [Int])
}

protocol GamesNavigationDelegate: AnyObject {
    func showDetail(with game: Game)
}
