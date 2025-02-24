//
//  FetchCharacterPageUseCaseTests.swift
//  MoveChallange
//
//  Created by Clinton on 24/02/2025.
//


@testable import MoveChallange
import Foundation
import Testing

struct FetchCharacterPageUseCaseTests {

    @Test func testFetchCharacterPageSuccess() async throws {
        let mockRepository = MockCharacterPageRepository()
        mockRepository.mockCharacterPageDTO = CharacterPageDTO(count: 10, next: nil, previous: nil, results: [])
        let useCase = FetchCharacterPageUseCase(repository: mockRepository)
        let characterPage = try await useCase.execute(for: 1)

        #expect(characterPage.count == 10)
    }

    @Test func testFetchCharacterPageFailure() async throws {
        let mockRepository = MockCharacterPageRepository()
        mockRepository.shouldThrowError = true
        let useCase = FetchCharacterPageUseCase(repository: mockRepository)
        
        await #expect(throws: NSError.self) {
            _ = try await useCase.execute(for: 1)
        }
    }
}
