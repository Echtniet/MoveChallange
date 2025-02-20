//
//  APIService.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol APIServiceProtocol {
    var baseURLString: String { get set }

    func fetchCharactersPage(for pageNumber: Int) async throws -> CharacterPageDTO
    func fetchFilmsPage(for pageNumber: Int) async throws -> FilmPageDTO
    func fetchSpaceshipsDTOPage(for pageNumber: Int) async throws -> SpaceshipPageDTO
}

class APIService: APIServiceProtocol {
    var baseURLString: String = "https://swapi.dev/api/"
}
