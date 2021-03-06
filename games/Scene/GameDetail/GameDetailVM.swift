//
//  GameDetailVM.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class GameDetailVM: GameDetailVMProtocol {
    weak var delegate: GameDetailVMOutputDelegate?
    
    private let game: Game
    
    private let networkManager: NetworkManager
    private let imageCacheManager: ImageCacheManager
    private let favouriteStorageService: FavouriteStorageService
    
    private var isFavourite: Bool {
        do {
            return try favouriteStorageService.getFavourite(game.id) != nil
        } catch {
            return false
        }
    }
    
    init(game: Game) {
        guard let container = app.container as? MainContainer else {
            fatalError("Wrong container is tried to use")
        }
        self.networkManager = container.networkManager
        self.imageCacheManager = container.imageCacheManager
        self.favouriteStorageService = FavouriteStorageService(storageManager: container.storageManager)
        self.game = game
    }
    
    func load() {
        if let url = game.imageUrl {
            if game.thumbnailData == nil {
                game.thumbnailData = self.imageCacheManager.getThumbnail(with: url)
            }
            if game.imageData == nil {
                game.imageData = self.imageCacheManager.getImage(with: url)
            }
        }
        delegate?.updateGamePresentation(GameDetailPresentation(game, isFavourite: isFavourite))
        
        if game.detail == nil {
            let dto = DetailRequestDTO(key: AppConfiguration.shared.apiKey)
            networkManager.request(.detail(id: UInt32(game.id), dto: dto)) { [weak self] (result: NetworkResult<DetailResponseDTO>) in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.game.detail = GameDetail(id: value.id,
                                                  description: value.description_raw ?? "",
                                                  redditUrl: value.reddit_url != "" ? value.reddit_url : nil,
                                                  websiteUrl: value.website != "" ? value.website : nil)
                    DispatchQueue.main.async {
                        self.delegate?.updateGamePresentation(GameDetailPresentation(self.game, isFavourite: self.isFavourite))
                    }
                case .failure(let error):
                    printError(error)
                }
            }
        }
        
        if game.imageData == nil,
           let url = game.imageUrl {
            networkManager.requestImageData(urlString: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    guard let compressedImageData = value.compressedImageData() else { return }
                    let dataWrapper = DataWrapper(data: value)
                    let compressedDataWrapper = DataWrapper(data: compressedImageData)
                    self.imageCacheManager.saveImage(key: url, dataWrapper: dataWrapper)
                    self.imageCacheManager.saveThumbnail(key: url, dataWrapper: compressedDataWrapper)
                    self.game.imageData = dataWrapper
                    self.game.thumbnailData = compressedDataWrapper
                    
                    DispatchQueue.main.async {
                        self.delegate?.updateGamePresentation(GameDetailPresentation(self.game, isFavourite: self.isFavourite))
                    }
                case .failure(let error):
                    printError(error)
                }
            }
        }
    }
    
    func toggleFavourite() {
        do {
            isFavourite
                ? try favouriteStorageService.removeFromFavourites(game.id)
                : try favouriteStorageService.addToFavourites(game)
            self.delegate?.updateGamePresentation(GameDetailPresentation(self.game, isFavourite: self.isFavourite))
        } catch {
            printError(error)
        }
    }
}
