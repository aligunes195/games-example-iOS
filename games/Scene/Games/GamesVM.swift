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
    private let thumbnailCache: NSCache<NSString, DataWrapper> = {
        let cache = NSCache<NSString, DataWrapper>()
        cache.countLimit = 1000
        return cache
    }()
    
    private(set) var items = [GamePresentation]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData(rows: nil)
            }
        }
    }
    
    init() {
        guard let container = app.container as? MainContainer else {
            fatalError("Wrong container is tried to use")
        }
        self.networkManager = container.networkManager
    }
    
    func load() {
        let dto = SearchRequestDTO(key: AppConfiguration.shared.apiKey,
                                   page_size: 10,
                                   page: 1,
                                   search: nil)
        self.networkManager.request(.search(dto: dto)) { [weak self] (result: NetworkResult<SearchListResponseDTO>) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                var noncachedImageUrls = [String]()
                self.items.append(contentsOf: value.results.map {
                    let dataWrapper = self.thumbnailCache.object(forKey: $0.background_image as NSString)
                    if dataWrapper == nil {
                        noncachedImageUrls.append($0.background_image)
                    }
                    
                    return GamePresentation(id: $0.id,
                                            name: $0.name,
                                            metacritic: $0.metacritic,
                                            genres: $0.genres.map { $0.name },
                                            clickedBefore: false,
                                            imageData: dataWrapper)
                })
                
                self.fetchNoncachedImages(urls: noncachedImageUrls)
            case .failure(let error):
                printError(error)
            }
        }
    }
    
    private func fetchNoncachedImages(urls: [String]) {
        
    }
}
