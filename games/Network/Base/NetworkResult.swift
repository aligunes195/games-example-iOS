//
//  NetworkResult.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(value: T)
    case failure(error: NetworkError)
}
