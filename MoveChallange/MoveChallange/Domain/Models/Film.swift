//
//  Film.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation
import SwiftData

struct Film: Hashable {
    let id: UUID
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
        self.id = UUID.fromHash("\(director)-\(episodeId)-\(openingCrawl)-\(producer)-\(releaseDate)-\(title)-\(url)")
    }

    init(model: FilmDataModel) {
        self.id = model.id
        self.characters = model.characters
        self.director = model.director
        self.episodeId = model.episodeId
        self.openingCrawl = model.openingCrawl
        self.planets = model.planets
        self.producer = model.producer
        self.releaseDate = model.releaseDate
        self.species = model.species
        self.starships = model.starships
        self.title = model.title
        self.url = model.url
        self.vehicles = model.vehicles
    }
}

@Model
final class FilmDataModel: FavoritesDataModelProtocol {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade)
    var characters: [String]
    var director: String
    var episodeId: Int
    var openingCrawl: String
    @Relationship(deleteRule: .cascade)
    var planets: [String]
    var producer: String
    var releaseDate: String
    @Relationship(deleteRule: .cascade)
    var species: [String]
    @Relationship(deleteRule: .cascade)
    var starships: [String]
    var title: String
    var url: String
    @Relationship(deleteRule: .cascade)
    var vehicles: [String]
    var cardStyle: CardStyles

    init(model: Film) {
        self.id = model.id
        self.characters = model.characters
        self.director = model.director
        self.episodeId = model.episodeId
        self.openingCrawl = model.openingCrawl
        self.planets = model.planets
        self.producer = model.producer
        self.releaseDate = model.releaseDate
        self.species = model.species
        self.starships = model.starships
        self.title = model.title
        self.url = model.url
        self.vehicles = model.vehicles
        self.cardStyle = model.cardStyle
    }
}

protocol FavoritesDataModelProtocol {
    var id: UUID { get }
    var cardStyle: CardStyles { get }
}
