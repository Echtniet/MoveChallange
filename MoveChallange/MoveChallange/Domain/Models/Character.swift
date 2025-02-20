//
//  Character.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct StarCharacter: Hashable {
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
    }

    enum Gender: String {
        case male
        case female
        case hermaphrodite
        case unknown
    }
}

