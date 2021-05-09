//
//  NetworkError.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case validateResponse
    case statusCode(code: Int, data: Data)
    case jsonEncoding(internal: Error)
    case jsonDecoding(internal: Error)
    
    var key: Int {
        switch self {
        case .validateResponse: return 0
        case .statusCode: return 1
        case .jsonEncoding: return 2
        case .jsonDecoding: return 3
        }
    }
}
