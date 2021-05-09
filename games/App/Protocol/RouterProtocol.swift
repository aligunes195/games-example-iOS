//
//  RouterProtocol.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

protocol RouterProtocol: class {
    var rootVC: UIViewController { get }
    
    func start()
}
