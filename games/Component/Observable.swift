//
//  Observable.swift
//  games
//
//  Created by Ali Güneş on 18.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

final class Observable<Value> {
    private var subscribers = [(Value?) -> Void]()
    
    var value: Value? {
        didSet {
            notifySubscribers()
        }
    }
    
    init(_ value: Value? = nil) {
        self.value = value
    }
    
    deinit {
        subscribers = []
    }
    
    func subscribe(_ block: @escaping (Value?) -> Void) {
        block(value)
        subscribers.append(block)
    }

    private func notifySubscribers() {
        subscribers.forEach{ $0(value) }
    }
    
    func cancelSubsriptions() {
        subscribers = []
    }
}
