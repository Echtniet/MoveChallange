//
//  Character.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct CharacterPage {
    let count: Int
    let hasNext: Bool
    let hasPrevious: Bool
    let results: [StarCharacter]

    init(dto: CharacterPageDTO) {
        self.count = dto.count
        self.hasNext = dto.next != nil
        self.hasPrevious = dto.previous != nil
        self.results = dto.results.map { StarCharacter(dto: $0) }
    }
}
