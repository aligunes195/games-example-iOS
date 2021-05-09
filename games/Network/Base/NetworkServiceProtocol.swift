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
