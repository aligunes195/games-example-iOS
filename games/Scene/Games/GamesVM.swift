//
//  GamesVM.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

final class GamesVM: GamesVMProtocol {
    private let networkManager: NetworkManager
    
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
        self.networkManager.request(.search(dto: dto)) { result in
            switch result {
            case .success(let value):
                print("success, value count: \(value.count)")
            case .failure(let error):
                printError(error)
            }
        }
    }
}
