//
//  Character.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation
import SwiftData

struct StarCharacter: Hashable {
    let id: UUID
    let brithYear: String
    let eyeColor: String
    let films: [String]
    let gender: Gender
    let hairColor: String
    let height: String
    let homeworld: String
    let name: String
    let species: [String]
    let starships: [String]
    let url: String
    let vehicles: [String]
    let cardStyle: CardStyles = .character

    init(dto: CharacterDTO) {
        self.brithYear = dto.birth_year
        self.eyeColor = dto.eye_color
        self.films = dto.films
        self.gender = Gender(rawValue: dto.gender) ?? .unknown
        self.hairColor = dto.hair_color
        self.height = dto.height
        self.homeworld = dto.homeworld
        self.name = dto.name
        self.species = dto.species
        self.starships = dto.starships
        self.url = dto.url
        self.vehicles = dto.vehicles
        self.id = UUID.fromHash("\(brithYear)-\(eyeColor)-\(gender)-\(hairColor)-\(height)-\(homeworld)-\(name)-\(url)")
    }

    init(model: StarCharacterDataModel) {
        self.id = model.id
        self.brithYear = model.brithYear
        self.eyeColor = model.eyeColor
        self.films = model.films
        self.gender = model.gender
        self.hairColor = model.hairColor
        self.height = model.height
        self.homeworld = model.homeworld
        self.name = model.name
        self.species = []//model.species
        self.starships = []//model.starships
        self.url = model.url
        self.vehicles = []//model.vehicles
    }

    enum Gender: String, Codable {
        case male
        case female
        case hermaphrodite
        case unknown
    }
}

@Model
final class StarCharacterDataModel: FavoritesDataModelProtocol {
    @Attribute(.unique) var id: UUID
    var brithYear: String
    var eyeColor: String
    @Relationship(deleteRule: .cascade)
    private var filmPersistent: [String]
    var films: [String] {
        get {
            filmPersistent
        }
        set {
            filmPersistent = newValue
        }
    }
    var gender: StarCharacter.Gender
    var hairColor: String
    var height: String
    var homeworld: String
    var name: String
    @Relationship(deleteRule: .cascade)
    private var speciesPersistent: [String]
    var species: [String] {
        get {
            speciesPersistent
        }
        set {
            speciesPersistent = newValue
        }
    }
    @Relationship(deleteRule: .cascade)
    private var starshipsPersistent: [String]
    var starships: [String] {
        get {
            starshipsPersistent
        }
        set {
            starshipsPersistent = newValue
        }
    }
    var url: String
    @Relationship(deleteRule: .cascade)
    private var vehiclesPersistent: [String]
    var vehicles: [String] {
        get {
            vehiclesPersistent
        }
        set {
            vehiclesPersistent = newValue
        }
    }
    var cardStyle: CardStyles

    init(model: StarCharacter) {
        self.id = model.id
        self.brithYear = model.brithYear
        self.eyeColor = model.eyeColor
        self.filmPersistent = model.films
        self.gender = model.gender
        self.hairColor = model.hairColor
        self.height = model.height
        self.homeworld = model.homeworld
        self.name = model.name
        self.speciesPersistent = model.species
        self.starshipsPersistent = model.starships
        self.url = model.url
        self.vehiclesPersistent = model.vehicles
        self.cardStyle = model.cardStyle
    }
}
