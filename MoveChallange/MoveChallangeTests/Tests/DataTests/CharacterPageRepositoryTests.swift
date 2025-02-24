//
//  CharacterPageRepositoryTests.swift
//  MoveChallange
//
//  Created by Clinton on 23/02/2025.
//

@testable import MoveChallange
import Foundation
import Testing

struct CharacterPageRepositoryTests {

    @Test
    func testFetchCharacterPageSuccess() async throws {
        let apiService = MockAPIService()
        apiService.mockCharacterPageDTO = CharacterPageDTO (count: 10, next: nil, previous: nil, results: [])
        let repository = CharacterPageRepository(apiService: apiService)

        let characterPage = try await repository.fetchCharactersPage(for: 1)

        #expect(characterPage.count == 10)
    }

    @Test
    func testFetchCharactersPageFailure() async throws {
        let apiService = MockAPIService()

        apiService.shouldThrowError = true
        let repository = CharacterPageRepository(apiService: apiService)

        await #expect(throws: NSError.self) {
            _ = try await repository.fetchCharactersPage(for: 1)
        }
    }
}
