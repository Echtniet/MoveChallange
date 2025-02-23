//
//  CharacterPageRepository.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Foundation

protocol CharacterPageRepositoryProtocol {
    func fetchCharactersPage(for pageNumber: Int, search criteria: String) async throws -> CharacterPage
}

class CharacterPageRepository: CharacterPageRepositoryProtocol {

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchCharactersPage(for pageNumber: Int, search criteria: String = "") async throws -> CharacterPage {
        let characterPageDTO = try await apiService.fetchCharactersPage(for: pageNumber, search: criteria)
        return CharacterPage(dto: characterPageDTO)
    }

}
