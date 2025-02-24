//
//  CharacterIntegrationTests.swift
//  MoveChallange
//
//  Created by Clinton on 24/02/2025.
//

@testable import MoveChallange
import Foundation
import Testing

struct CharacterIntegrationTests {

    @Test func testCharacterFetchingFlow() async throws {
        let mockAPI = MockAPIService()
        let repository = CharacterPageRepository(apiService: mockAPI)
        let useCase = FetchCharacterPageUseCase(repository: repository)

        let viewModel = CharacterPageViewModel(
            fetchCharacterPageUseCase: useCase,
            filterCharacterGenderUseCase: FilterCharacterGenderUseCase()
        )

        await viewModel.fetchCharacters()

        #expect(viewModel.count == 10)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.hasNext)
        #expect(viewModel.errorMessage == nil)
    }
}
