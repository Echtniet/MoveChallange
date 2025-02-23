//
//  FilmRepository.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol FilmRepositoryProtocol {
    func fetchFilm(urlString: String) async throws -> Film
    func fetchFilms(urlStrings: [String]) async throws -> [Film]
}

class FilmRepository: FilmRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchFilm(urlString: String) async throws -> Film {
        let filmDTO = try await apiService.fetchFilm(urlString: urlString)
        return Film(dto: filmDTO)
    }

    func fetchFilms(urlStrings: [String]) async throws -> [Film] {
        return try await withThrowingTaskGroup(of: Film.self) { group in
            for urlString in urlStrings {
                group.addTask {
                    return try await self.fetchFilm(urlString: urlString)
                }
            }

            var films: [Film] = []
            for try await film in group {
                films.append(film)
            }

            return films
        }
    }
}
