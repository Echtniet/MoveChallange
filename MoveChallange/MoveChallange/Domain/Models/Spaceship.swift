//
//  Spaceship.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation
import SwiftData

struct Spaceship: Hashable {
    let id: UUID
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
        self.id = UUID.fromHash("\(MGLT)-\(cargoCapacity)-\(consumables)-\(costInCredits)-\(created)-\(hyperdriveRating)-\(length)-\(maxAtmospheringSpeed)-\(model)-\(name)-\(passengers)-\(url)")
    }

    init(model: SpaceshipDataModel) {
        self.id = model.id
        self.MGLT = model.MGLT
        self.cargoCapacity = model.cargoCapacity
        self.consumables = model.consumables
        self.costInCredits = model.costInCredits
        self.created = model.created
        self.crew = model.crew
        self.hyperdriveRating = model.hyperdriveRating
        self.length = model.length
        self.maxAtmospheringSpeed = model.maxAtmospheringSpeed
        self.model = model.model
        self.name = model.name
        self.passengers = model.passengers
        self.films = model.films
        self.pilots = model.pilots
        self.starshipClass = model.starshipClass
        self.url = model.url
    }
}

@Model
final class SpaceshipDataModel: FavoritesDataModelProtocol {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade)
    var MGLT: String
    var cargoCapacity: String
    var consumables: String
    var costInCredits: String
    var created: String
    var crew: String
    var hyperdriveRating: String
    var length: String
    var maxAtmospheringSpeed: String
    var model: String
    var name: String
    var passengers: String
    @Relationship(deleteRule: .cascade)
    var films: [String]
    @Relationship(deleteRule: .cascade)
    var pilots: [String]
    var starshipClass: String
    var url: String
    var cardStyle: CardStyles

    init(model: Spaceship) {
        self.id = model.id
        self.MGLT = model.MGLT
        self.cargoCapacity = model.cargoCapacity
        self.consumables = model.consumables
        self.costInCredits = model.costInCredits
        self.created = model.created
        self.crew = model.crew
        self.hyperdriveRating = model.hyperdriveRating
        self.length = model.length
        self.maxAtmospheringSpeed = model.maxAtmospheringSpeed
        self.model = model.model
        self.name = model.name
        self.passengers = model.passengers
        self.films = model.films
        self.pilots = model.pilots
        self.starshipClass = model.starshipClass
        self.url = model.url
        self.cardStyle = model.cardStyle
    }
}
