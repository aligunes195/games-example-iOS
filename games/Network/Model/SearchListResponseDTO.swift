//
//  SearchListResponseDTO.swift
//  games
//
//  Created by ali güneş on 10.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

struct SearchListResponseDTO: Decodable {
    let results: [SearchResponseDTO]
}
