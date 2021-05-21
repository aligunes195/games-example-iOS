//
//  FavouriteStorageService.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class FavouriteStorageService: StorageService {
    private let allKey = "\(AppConfiguration.shared.bundleIdentifier).favourite.storage.service.all.ids"
    
    override func key(with id: Any) -> String {
        return "\(AppConfiguration.shared.bundleIdentifier).favourite.storage.service.\(id)"
    }
    
    func addToFavourites(_ game: Game) throws {
        var allIds: [Int] = [game.id]
        if let allIdsData = self.storageManager.load(allKey) {
            allIds.append(contentsOf: try allIdsData.toJSONObject([Int].self))
        }
        
        let model = FavouriteStorageModel(game: game)
        if let dataWrapper = game.thumbnailData {
            let thumbnailUrl = AppConfiguration.shared.thumbnailsURL.appendingPathComponent("\(game.id)")
            try dataWrapper.data.write(to: thumbnailUrl)
        }
        if let dataWrapper = game.imageData {
            let imageUrl = AppConfiguration.shared.imagesURL.appendingPathComponent("\(game.id)")
            try dataWrapper.data.write(to: imageUrl)
        }
        self.storageManager.save(allKey, value: try allIds.toJSONData())
        self.storageManager.save(key(with: model.id), value: try model.toJSONData())
    }
    
    func removeFromFavourites(_ id: Int) throws {
        let thumbnailUrl = AppConfiguration.shared.thumbnailsURL.appendingPathComponent("\(id)")
        if FileManager.default.fileExists(atPath: thumbnailUrl.path) {
            try FileManager.default.removeItem(at: thumbnailUrl)
        }
        let imageUrl = AppConfiguration.shared.imagesURL.appendingPathComponent("\(id)")
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            try FileManager.default.removeItem(at: imageUrl)
        }
        self.storageManager.remove(key(with: id))
    }
    
    func getFavourite(_ id: Int) throws -> Game? {
        guard let data = self.storageManager.load(key(with: id)) else {
            return nil
        }
        let model = try data.toJSONObject(FavouriteStorageModel.self)
        
        let thumbnailData: DataWrapper?
        let thumbnailUrl = AppConfiguration.shared.thumbnailsURL.appendingPathComponent("\(id)")
        if FileManager.default.fileExists(atPath: thumbnailUrl.path) {
            thumbnailData = DataWrapper(data: try Data(contentsOf: thumbnailUrl))
        } else {
            thumbnailData = nil
        }
        
        let imageData: DataWrapper?
        let imageUrl = AppConfiguration.shared.imagesURL.appendingPathComponent("\(id)")
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            imageData = DataWrapper(data: try Data(contentsOf: imageUrl))
        } else {
            imageData = nil
        }
        
        return Game(id: model.id,
                    name: model.name,
                    metacritic: model.metacritic,
                    imageUrl: model.imageUrl,
                    genres: model.genres,
                    detail: GameDetail(id: model.id,
                                       description: model.description,
                                       redditUrl: model.redditUrl,
                                       websiteUrl: model.websiteUrl),
                    thumbnailData: thumbnailData,
                    imageData: imageData)
    }
    
    func getAllFavourites() throws -> [Game] {
        guard let allIdsData = self.storageManager.load(allKey) else {
            return []
        }
        let allIds = try allIdsData.toJSONObject([Int].self)
        return allIds.compactMap { return try? getFavourite($0) }
    }
}
