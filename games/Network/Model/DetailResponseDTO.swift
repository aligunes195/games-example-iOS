//
//  DetailResponseDTO.swift
//  games
//
//  Created by Ali Güneş on 19.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

struct DetailResponseDTO: Decodable {
    let id: Int
    let description_raw: String?
    let website: String?
    let reddit_url: String?
}
