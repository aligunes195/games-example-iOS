//
//  Data.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

extension Data {
    static var emptyJSONData: Data {
        return "{}".data(using: .utf8)!
    }
    
    func toJSONObject<T: Decodable>(_ type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: self.isEmpty ? Data.emptyJSONData : self)
    }
    
    func compressedImageData() -> Data? {
        guard let image = UIImage(data: self) else { return nil }
        return image.compressForThumbnail()
    }
}
