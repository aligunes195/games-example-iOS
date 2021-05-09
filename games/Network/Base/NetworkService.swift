//
//  NetworkServiceProtocol.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Alamofire

protocol NetworkServiceProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var object: Encodable? { get }
    var headers: HTTPHeaders? { get }
}

enum NetworkService {
    case search(dto: SearchRequestDTO)
    case detail(id: UInt32, dto: DetailRequestDTO)
}

extension NetworkService: NetworkServiceProtocol {
    var path: String {
        switch self {
        case .search: return "/api/games"
        case .detail(let id, _): return "/api/games/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search: return .get
        case .detail: return .get
        }
    }
    
    var object: Encodable? {
        switch self {
        case .search(let dto): return dto
        case .detail(_, let dto): return dto
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
