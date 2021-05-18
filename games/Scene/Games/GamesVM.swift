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
    
    var query: String {
        didSet {
            if query.count > 3 {
                initialLoadDone = false
                self.load(initial: true, page: 1, completion: nil)
            }
        }
    }
    
    private let networkManager: NetworkManager
    private let imageCacheManager: ImageCacheManager
    
    private let pageSize = 50
    private let maxPageCount = 4
    private let gamesClickedBeforeCache = NSCache<NSString, Game>()
    
    private var items = [Game]()
    
    private var lastPage: UInt32 = 1
    private var initialLoadDone: Bool = false
    
    init() {
        guard let container = app.container as? MainContainer else {
            fatalError("Wrong container is tried to use")
        }
        self.networkManager = container.networkManager
        self.imageCacheManager = container.imageCacheManager
        self.query = ""
    }
    
    func load() {
        load(initial: true, page: 1, completion: nil)
    }
    
    func loadMore(completion: (() -> Void)?) {
        load(initial: false, page: lastPage + 1, completion: completion)
    }
    
    func numberOfGames() -> Int {
        return items.count
    }
    
    func getGame(at indexPath: IndexPath) -> GamePresentation {
        let game = items[indexPath.row]
        let clickedBefore = gamesClickedBeforeCache.object(forKey: "\(game.id)" as NSString) != nil
        
        return GamePresentation(items[indexPath.row], clickedBefore: clickedBefore)
    }
    
    func selectGame(at indexPath: IndexPath) {
        let game = items[indexPath.row]
        gamesClickedBeforeCache.setObject(game, forKey: "\(game.id)" as NSString)
    }
    
    private func load(initial: Bool, page: UInt32, completion: (() -> Void)?) {
        guard initial || initialLoadDone else {
            completion?()
            return
        }
        
        let dto = SearchRequestDTO(key: AppConfiguration.shared.apiKey,
                                   page_size: UInt32(self.pageSize),
                                   page: page,
                                   search: self.query)
        self.networkManager.request(.search(dto: dto)) { [weak self] (result: NetworkResult<SearchListResponseDTO>) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                var gamesWithNoncachedImage = [Game]()
                let newElements: [Game] = value.results.map {
                    guard let imageUrl = $0.background_image else {
                        return Game(dto: $0)
                    }
                    
                    let dataWrapper: DataWrapper? = self.imageCacheManager.getThumbnail(with: imageUrl)
                    let game = Game(dto: $0,
                                    thumbnailData: dataWrapper)
                    if dataWrapper == nil {
                        gamesWithNoncachedImage.append(game)
                    }
                    return game
                }
                
                self.fetchNoncachedImages(games: gamesWithNoncachedImage)
                self.lastPage = page
                if initial {
                    self.items = newElements
                    self.initialLoadDone = true
                } else {
                    self.items.append(contentsOf: newElements)
                }
                
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
            guard let url = game.imageUrl else { return }
            self.networkManager.requestImageData(urlString: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    guard let compressedImageData = value.compressedImageData() else { return }
                    let dataWrapper = DataWrapper(data: value)
                    let compressedDataWrapper = DataWrapper(data: compressedImageData)
                    self.imageCacheManager.saveImage(key: url, dataWrapper: dataWrapper)
                    self.imageCacheManager.saveThumbnail(key: url, dataWrapper: compressedDataWrapper)
                    game.thumbnailData = compressedDataWrapper
                    
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
