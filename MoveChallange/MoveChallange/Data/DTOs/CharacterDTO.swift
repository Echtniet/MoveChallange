//
//  CharacterDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct CharacterDTO: Codable {
    let birth_year: String
    let eye_color: String
    let films: [String]
    let gender: String
    let hair_color: String
    let height: String
    let homeworld: String
    let name: String
    let created: String
    let edited: String
    let species: [String]
    let starships: [String]
    let url: String
    let vehicles: [String]
}
