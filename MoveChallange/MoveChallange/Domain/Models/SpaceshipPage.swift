//
//  Spaceship.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct SpaceshipPage {
    let count: Int
    let hasNext: Bool
    let hasPrevious: Bool
    let results: [Spaceship]

    init(dto: SpaceshipPageDTO) {
        self.count = dto.count
        self.hasNext = dto.next != nil
        self.hasPrevious = dto.previous != nil
        self.results = dto.results.map { Spaceship(dto: $0) }
    }
}
