//
//  FetchSpaceshipPageUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol FetchSpaceshipPageUseCaseProtocol {
    func execute(for pageNumber: Int) async throws -> SpaceshipPage
}

class FetchSpaceshipPageUseCase: FetchSpaceshipPageUseCaseProtocol {
    private let repository: SpaceshipPageRepositoryProtocol

    init(repository: SpaceshipPageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for pageNumber: Int) async throws -> SpaceshipPage {
        return try await repository.fetchSpaceshipPage(for: pageNumber)
    }
}
