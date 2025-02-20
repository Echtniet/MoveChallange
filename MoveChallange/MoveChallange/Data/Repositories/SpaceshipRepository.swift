//
//  SpaceshipRepository.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol SpaceshipPageRepositoryProtocol {
    func fetchSpaceshipPage(for pageNumber: Int) async throws -> SpaceshipPage
}

class SpaceshipPageRepository: SpaceshipPageRepositoryProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchSpaceshipPage(for pageNumber: Int) async throws -> SpaceshipPage {
        let spaceshipPageDTO = try await apiService.fetchSpaceshipsDTOPage(for: pageNumber)
        return SpaceshipPage(dto: spaceshipPageDTO)
    }

}
