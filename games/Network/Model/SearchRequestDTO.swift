//
//  SearchRequestDTO.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

struct SearchRequestDTO: Encodable {
    let page_size: UInt32
    let page: UInt32
    let search: String?
}
