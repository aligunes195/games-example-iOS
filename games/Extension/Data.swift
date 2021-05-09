//
//  Data.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

extension Data {
    static var emptyJSONData: Data {
        return "{}".data(using: .utf8)!
    }
    
    func toJSONObject<T: Decodable>(_ type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: self.isEmpty ? Data.emptyJSONData : self)
    }
}
