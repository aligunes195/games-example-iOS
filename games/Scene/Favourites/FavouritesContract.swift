//
//  FavouritesContract.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

protocol FavouritesVMProtocol: class {
    var delegate: FavouritesVMOutputDelegate? { get set }
    
    func load()
    
    func numberOfFavourites() -> Int
    func getFavouritePresentation(at indexPath: IndexPath) -> FavouritePresentation
    func getGame(at indexPath: IndexPath) -> Game
    func deleteFavourite(at indexPath: IndexPath)
}

protocol FavouritesVMOutputDelegate: class {
    func reloadData(rows: [Int]?)
    func deleteData(rows: [Int])
}

protocol FavouritesNavigationDelegate: class {
    func showDetail(with game: Game)
}
