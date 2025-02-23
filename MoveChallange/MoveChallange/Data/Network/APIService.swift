//
//  APIService.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol APIServiceProtocol {
    var baseURLString: String { get set }

    func fetchCharactersPage(for pageNumber: Int, search criteria: String) async throws -> CharacterPageDTO
    func fetchFilmsPage(for pageNumber: Int, search criteria: String) async throws -> FilmPageDTO
    func fetchSpaceshipsDTOPage(for pageNumber: Int, search criteria: String) async throws -> SpaceshipPageDTO
    func fetchCharacter(urlString: String) async throws -> CharacterDTO
    func fetchFilm(urlString: String) async throws -> FilmDTO
    func fetchSpaceship(urlString: String) async throws -> SpaceshipDTO
}

class APIService: APIServiceProtocol {
    var baseURLString: String = "https://swapi.dev/api/"
}
