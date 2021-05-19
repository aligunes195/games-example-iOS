//
//  StorageProvider.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

class StorageProvider {
    internal let storageManager: StorageManager
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    func key(with id: Any) -> String {
        fatalError("StorageProvider: should be overwritten")
    }
}
