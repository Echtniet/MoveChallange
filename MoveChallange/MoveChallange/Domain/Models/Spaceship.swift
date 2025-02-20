//
//  Spaceship.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct Spaceship: Hashable {
    let MGLT: String
    let cargoCapacity: String
    let consumables: String
    let costInCredits: String
    let created: String
    let crew: String
    let hyperdriveRating: String
    let length: String
    let maxAtmospheringSpeed: String
    let model: String
    let name: String
    let passengers: String
    let films: [String]
    let pilots: [String]
    let starshipClass: String
    let url: String
    let cardStyle: CardStyles = .spaceship

    init(dto: SpaceshipDTO) {
        self.MGLT = dto.MGLT
        self.cargoCapacity = dto.cargo_capacity
        self.consumables = dto.consumables
        self.costInCredits = dto.cost_in_credits
        self.created = dto.created
        self.crew = dto.crew
        self.hyperdriveRating = dto.hyperdrive_rating
        self.length = dto.length
        self.maxAtmospheringSpeed = dto.max_atmosphering_speed
        self.model = dto.model
        self.name = dto.name
        self.passengers = dto.passengers
        self.films = dto.films
        self.pilots = dto.pilots
        self.starshipClass = dto.starship_class
        self.url = dto.url
    }
}
