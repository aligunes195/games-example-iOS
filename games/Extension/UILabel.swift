//
//  UILabel.swift
//  games
//
//  Created by ali güneş on 21.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

private var key: String = "localizableKey"

extension UILabel {
    @IBInspectable var localizableKey: String? {
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            guard let newValue = newValue else { return }
            self.text = String.localized(newValue)
        }
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
    }
}
