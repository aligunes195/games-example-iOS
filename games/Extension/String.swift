//
//  String.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

extension String {
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    static func localized(_ key: String, _ parameters: String...) -> String {
        return String(format: localized(key), arguments: parameters)
    }
}
