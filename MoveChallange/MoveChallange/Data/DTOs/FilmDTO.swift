//
//  FilmDTO.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

struct FilmDTO: Codable {
    let characters: [String]
    let created: String
    let director: String
    let edited: String
    let episode_id: Int
    let opening_crawl: String
    let planets: [String]
    let producer: String
    let release_date: String
    let species: [String]
    let starships: [String]
    let title: String
    let url: String
    let vehicles: [String]
}
