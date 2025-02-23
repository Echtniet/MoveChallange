//
//  FetchCharacterByIdUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol FetchCharacterByIdUseCaseProtocol {
    func execute(urlString: String) async throws -> StarCharacter
    func execute(urlStrings: [String]) async throws -> [StarCharacter]
}

class FetchCharacterByIdUseCase: FetchCharacterByIdUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(urlString: String) async throws -> StarCharacter {
        return try await repository.fetchCharacter(urlString: urlString)
    }

    func execute(urlStrings: [String]) async throws -> [StarCharacter] {
        return try await repository.fetchCharacters(urlStrings: urlStrings)
    }
}
