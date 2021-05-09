//
//  UIStoryboard.swift
//  games
//
//  Created by ali güneş on 10.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func load(_ name: StoryboardName, identifier: String? = nil) -> UIViewController {
        let sb = UIStoryboard(name: name.rawValue, bundle: nil)
        
        if let identifier = identifier {
            return sb.instantiateViewController(withIdentifier: identifier)
        } else {
            return sb.instantiateInitialViewController()!
        }
    }
}
