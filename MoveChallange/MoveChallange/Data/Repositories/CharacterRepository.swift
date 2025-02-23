//
//  CharacterRepository.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacter(urlString: String) async throws -> StarCharacter
    func fetchCharacters(urlStrings: [String]) async throws -> [StarCharacter]
}

class CharacterRepository: CharacterRepositoryProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchCharacter(urlString: String) async throws -> StarCharacter {
        let characterDTO = try await apiService.fetchCharacter(urlString: urlString)
        return StarCharacter(dto: characterDTO)
    }

    func fetchCharacters(urlStrings: [String]) async throws -> [StarCharacter] {
        return try await withThrowingTaskGroup(of: StarCharacter.self) { group in
            for urlString in urlStrings {
                group.addTask {
                    return try await self.fetchCharacter(urlString: urlString)
                }
            }

            var characters: [StarCharacter] = []
            for try await character in group {
                characters.append(character)
            }

            return characters
        }
    }
}
