//
//  FilmPageDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct FilmPageDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [FilmDTO]
}
