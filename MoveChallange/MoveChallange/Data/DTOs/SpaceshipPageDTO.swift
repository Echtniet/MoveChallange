//
//  SpaceshipPageDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct SpaceshipPageDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [SpaceshipDTO]
}
