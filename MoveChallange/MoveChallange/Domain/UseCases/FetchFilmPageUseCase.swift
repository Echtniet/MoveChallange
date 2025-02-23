//
//  FetchFilmPageUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.

//
import Foundation

protocol FetchFilmPageUseCaseProtocol {
    func execute(for pageNumber: Int, search criteria: String) async throws -> FilmPage
}

class FetchFilmPageUseCase: FetchFilmPageUseCaseProtocol {
    private let repository: FilmPageRepositoryProtocol

    init(repository: FilmPageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for pageNumber: Int, search criteria: String) async throws -> FilmPage {
        return try await repository.fetchFilmsPage(for: pageNumber, search: criteria)
    }
}
