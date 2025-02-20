//
//  CharacterPageRepository.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol CharacterPageRepositoryProtocol {
    func fetchCharactersPage(for pageNumber: Int) async throws -> CharacterPage
}

class CharacterPageRepository: CharacterPageRepositoryProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchCharactersPage(for pageNumber: Int) async throws -> CharacterPage {
        let characterPageDTO = try await apiService.fetchCharactersPage(for: pageNumber)
        return CharacterPage(dto: characterPageDTO)
    }

}
