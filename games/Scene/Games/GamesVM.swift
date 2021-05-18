//
//  GamesVM.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

final class GamesVM: GamesVMProtocol {
    weak var delegate: GamesVMOutputDelegate?
    
    private let networkManager: NetworkManager
    private let imageCacheManager: ImageCacheManager
    
    private let pageSize = 50
    private let maxPageCount = 4
    
    private var items = [Game]()
    
    private var lastPage: UInt32 = 1
    
    init() {
        guard let container = app.container as? MainContainer else {
            fatalError("Wrong container is tried to use")
        }
        self.networkManager = container.networkManager
        self.imageCacheManager = container.imageCacheManager
    }
    
    func load() {
        load(page: 1, completion: nil)
    }
    
    func loadMore(completion: (() -> Void)?) {
        load(page: lastPage + 1, completion: completion)
    }
    
    func numberOfGames() -> Int {
        return items.count
    }
    
    func getGame(at indexPath: IndexPath) -> GamePresentation {
        return GamePresentation(items[indexPath.row])
    }
    
    func selectGame(at indexPath: IndexPath) {
        
    }
    
    private func load(page: UInt32, completion: (() -> Void)?) {
        let dto = SearchRequestDTO(key: AppConfiguration.shared.apiKey,
                                   page_size: UInt32(self.pageSize),
                                   page: page,
                                   search: nil)
        self.networkManager.request(.search(dto: dto)) { [weak self] (result: NetworkResult<SearchListResponseDTO>) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                var gamesWithNoncachedImage = [Game]()
                let newElements: [Game] = value.results.map {
                    let dataWrapper: DataWrapper? = self.imageCacheManager.getThumbnail(with: $0.background_image)
                    
                    let game = Game(dto: $0,
                                    clickedBefore: false,
                                    imageData: dataWrapper)
                    if dataWrapper == nil {
                        gamesWithNoncachedImage.append(game)
                    }
                    return game
                }
                
                self.fetchNoncachedImages(games: gamesWithNoncachedImage)
                self.lastPage = page
                self.items.append(contentsOf: newElements)
                DispatchQueue.main.async {
                    self.delegate?.insertData(rows: Array((self.items.count - newElements.count)..<self.items.count))
                    completion?()
                }
            case .failure(let error):
                printError(error)
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    private func fetchNoncachedImages(games: [Game]) {
        games.forEach { game in
            self.networkManager.requestImageData(urlString: game.imageUrl) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    guard let compressedImageData = value.compressedImageData() else { return }
                    let dataWrapper = DataWrapper(data: value)
                    let compressedDataWrapper = DataWrapper(data: compressedImageData)
                    self.imageCacheManager.saveImage(key: game.imageUrl, dataWrapper: dataWrapper)
                    self.imageCacheManager.saveThumbnail(key: game.imageUrl, dataWrapper: compressedDataWrapper)
                    game.imageData = compressedDataWrapper
                    
                    DispatchQueue.main.async {
                        guard let delegate = self.delegate,
                              delegate.isVisible(id: game.id),
                              let index = self.items.firstIndex(where: { $0.id == game.id})
                        else { return }
                        
                        self.delegate?.reloadData(rows: [index])
                    }
                case .failure(let error):
                    printError(error)
                }
            }
        }
    }
}
