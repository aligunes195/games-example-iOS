//
//  SearchBuilder.swift
//  games
//
//  Created by ali güneş on 1.06.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import Foundation

final class SearchBuilder {
    static func build() -> SearchVC {
        let vc = SearchVC()
        vc.vm = SearchVM()
        return vc
    }
}
