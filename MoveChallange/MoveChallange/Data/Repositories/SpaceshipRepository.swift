//
//  SpaceshipRepository.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol SpaceshipRepositoryProtocol {
    func fetchSpaceship(urlString: String) async throws -> Spaceship
    func fetchSpaceships(urlStrings: [String]) async throws -> [Spaceship]
}

class SpaceshipRepository: SpaceshipRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchSpaceship(urlString: String) async throws -> Spaceship {
        let spaceshipDTO = try await apiService.fetchSpaceship(urlString: urlString)
        return Spaceship(dto: spaceshipDTO)
    }

    func fetchSpaceships(urlStrings: [String]) async throws -> [Spaceship] {
        return try await withThrowingTaskGroup(of: Spaceship.self) { group in
            for urlString in urlStrings {
                group.addTask {
                    return try await self.fetchSpaceship(urlString: urlString)
                }
            }

            var spaceships: [Spaceship] = []
            for try await spaceship in group {
                spaceships.append(spaceship)
            }

            return spaceships
        }
    }
}
