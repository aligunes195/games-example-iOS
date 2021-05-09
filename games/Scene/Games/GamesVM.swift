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
    
    private(set) var items = [GamePresentation]() {
        didSet {
            
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
                                   search: "gtav")
        self.networkManager.request(.search(dto: dto)) { [weak self] (result: NetworkResult<SearchListResponseDTO>) in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.items.append(contentsOf: value.results.map {
                    GamePresentation(id: $0.id,
                                     name: $0.name,
                                     metacritic: $0.metacritic,
                                     genres: $0.genres.map { $0.name },
                                     clickedBefore: false,
                                     imageUrl: nil)
                })
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                printError(error)
            }
        }
    }
}
