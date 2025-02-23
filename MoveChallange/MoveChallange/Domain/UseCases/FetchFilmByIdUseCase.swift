//
//  FetchFilmByIdUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol FetchFilmByIdUseCaseProtocol {
    func execute(urlString: String) async throws -> Film
    func execute(urlStrings: [String]) async throws -> [Film]
}

class FetchFilmByIdUseCase: FetchFilmByIdUseCaseProtocol {
    private let repository: FilmRepositoryProtocol

    init(repository: FilmRepositoryProtocol) {
        self.repository = repository
    }

    func execute(urlString: String) async throws -> Film {
        return try await repository.fetchFilm(urlString: urlString)
    }

    func execute(urlStrings: [String]) async throws -> [Film] {
        return try await repository.fetchFilms(urlStrings: urlStrings)
    }
}
