//
//  StorageManager.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class StorageManager {
    private let userDefaults: UserDefaults = {
        guard let defaults = UserDefaults(suiteName: AppConfiguration.shared.appGroupIdentifier) else {
            fatalError("StorageManager: UserDefaults could not be initialized")
        }
        return defaults
    }()
    
    private let writeQueue = DispatchQueue(label: "\(AppConfiguration.shared.bundleIdentifier).storage.manager.write.queue",
                                           qos: .userInitiated)
    private let readQueue = DispatchQueue(label: "\(AppConfiguration.shared.bundleIdentifier).storage.manager.read.queue",
                                          qos: .userInitiated,
                                          attributes: .concurrent)
    
    func save(_ key: String, value: Any) {
        writeQueue.sync {
            self.userDefaults.set(value, forKey: key)
        }
    }
    
    func load(_ key: String) -> Any? {
        readQueue.sync {
            return self.userDefaults.value(forKey: key)
        }
    }
    
    func remove(_ key: String) {
        writeQueue.sync {
            self.userDefaults.removeObject(forKey: key)
        }
    }
}
