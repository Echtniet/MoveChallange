//
//  FetchCharacterPageUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol FetchCharacterPageUseCaseProtocol {
    func execute(for pageNumber: Int, search criteria: String) async throws -> CharacterPage
}

class FetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol {
    private let repository: CharacterPageRepositoryProtocol

    init(repository: CharacterPageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for pageNumber: Int, search criteria: String = "") async throws -> CharacterPage {
        return try await repository.fetchCharactersPage(for: pageNumber, search: criteria)
    }
}
