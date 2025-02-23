//
//  FetchSpaceshipByIdUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol FetchSpaceshipByIdUseCaseProtocol {
    func execute(urlString: String) async throws -> Spaceship
    func execute(urlStrings: [String]) async throws -> [Spaceship]
}

class FetchSpaceshipByIdUseCase: FetchSpaceshipByIdUseCaseProtocol {
    private let repository: SpaceshipRepositoryProtocol

    init(repository: SpaceshipRepositoryProtocol) {
        self.repository = repository
    }

    func execute(urlString: String) async throws -> Spaceship {
        return try await repository.fetchSpaceship(urlString: urlString)
    }

    func execute(urlStrings: [String]) async throws -> [Spaceship] {
        return try await repository.fetchSpaceships(urlStrings: urlStrings)
    }
}
