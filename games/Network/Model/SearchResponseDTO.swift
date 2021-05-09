//
//  SearchResponseDTO.swift
//  games
//
//  Created by ali güneş on 10.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import Foundation

struct SearchResponseDTO: Decodable {
    let id: Int
    let name: String
    let metacritic: Int?
    let background_image: String
    let genres: [GenreResponseDTO]
}
