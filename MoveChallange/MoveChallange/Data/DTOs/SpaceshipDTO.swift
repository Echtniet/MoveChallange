//
//  SpaceshipDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct SpaceshipDTO: Codable {
    let MGLT: String
    let cargo_capacity: String
    let consumables: String
    let cost_in_credits: String
    let created: String
    let crew: String
    let edited: String
    let hyperdrive_rating: String
    let length: String
    let max_atmosphering_speed: String
    let model: String
    let name: String
    let passengers: String
    let films: [String]
    let pilots: [String]
    let starship_class: String
    let url: String
}
