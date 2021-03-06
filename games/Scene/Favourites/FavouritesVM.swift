//
//  FavouritesVM.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class FavouritesVM: FavouritesVMProtocol {
    var delegate: FavouritesVMOutputDelegate?
    
    private let favouriteStorageService: FavouriteStorageService
    
    private var items = [Game]() {
        didSet {
            self.delegate?.updateTitle()
        }
    }
    
    init() {
        guard let container = app.container as? MainContainer else {
            fatalError("Wrong container is tried to use")
        }
        self.favouriteStorageService = FavouriteStorageService(storageManager: container.storageManager)
    }
    
    func load() {
        do {
            items = try favouriteStorageService.getAllFavourites()
            delegate?.reloadData(rows: nil)
        } catch {
            printError(error)
        }
    }
    
    func numberOfFavourites() -> Int {
        return items.count
    }
    
    func getFavouritePresentation(at indexPath: IndexPath) -> FavouritePresentation {
        return FavouritePresentation(items[indexPath.row])
    }
    
    func getGame(at indexPath: IndexPath) -> Game {
        return items[indexPath.row]
    }
    
    func deleteFavourite(at indexPath: IndexPath) {
        do {
            try favouriteStorageService.removeFromFavourites(items[indexPath.row].id)
            items.remove(at: indexPath.row)
            delegate?.deleteData(rows: [indexPath.row])
        } catch {
            printError(error)
        }
    }
}
