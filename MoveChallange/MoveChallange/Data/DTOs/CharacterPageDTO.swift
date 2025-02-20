//
//  CharacterPageDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct CharacterPageDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [CharacterDTO]
}
