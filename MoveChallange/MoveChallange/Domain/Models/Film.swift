//
//  Film.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

struct Film: Hashable {
    let characters: [String]
    let director: String
    let episodeId: Int
    let openingCrawl: String
    let planets: [String]
    let producer: String
    let releaseDate: String
    let species: [String]
    let starships: [String]
    let title: String
    let url: String
    let vehicles: [String]
    let cardStyle: CardStyles = .film

    init(dto: FilmDTO) {
        self.characters = dto.characters
        self.director = dto.director
        self.episodeId = dto.episode_id
        self.openingCrawl = dto.opening_crawl
        self.planets = dto.planets
        self.producer = dto.producer
        self.releaseDate = dto.release_date
        self.species = dto.species
        self.starships = dto.starships
        self.title = dto.title
        self.url = dto.url
        self.vehicles = dto.vehicles
    }
}
