//
//  FavouritesContract.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

protocol FavouritesVMProtocol: AnyObject {
    var delegate: FavouritesVMOutputDelegate? { get set }
    
    func load()
    
    func numberOfFavourites() -> Int
    func getFavouritePresentation(at indexPath: IndexPath) -> FavouritePresentation
    func getGame(at indexPath: IndexPath) -> Game
    func deleteFavourite(at indexPath: IndexPath)
}

protocol FavouritesVMOutputDelegate: AnyObject {
    func reloadData(rows: [Int]?)
    func deleteData(rows: [Int])
    func updateTitle()
}

protocol FavouritesNavigationDelegate: AnyObject {
    func showDetail(with game: Game)
}
