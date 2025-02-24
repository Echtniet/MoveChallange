//
//  CharacterPageViewModelTests.swift
//  MoveChallange
//
//  Created by Clinton on 24/02/2025.
//

@testable import MoveChallange
import Foundation
import Testing

struct CharacterPageViewModelTests {

    @Test func testFetchCharacterPageSuccess() async throws {
        let mockUseCase = MockFetchCharacterPageUseCase()
        let viewModel = CharacterPageViewModel(
            fetchCharacterPageUseCase: mockUseCase,
            filterCharacterGenderUseCase: FilterCharacterGenderUseCase()
        )

        await viewModel.fetchCharacters()

        #expect(viewModel.count == 10)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.hasNext)
        #expect(viewModel.errorMessage == nil)
    }

    @Test func testFetchCharactersPageFailure() async throws {
        let mockUseCase = MockFetchCharacterPageUseCase()
        mockUseCase.shouldThrowError = true

        let viewModel = CharacterPageViewModel(
            fetchCharacterPageUseCase: mockUseCase,
            filterCharacterGenderUseCase: FilterCharacterGenderUseCase()
        )

        await viewModel.fetchCharacters()

        #expect(viewModel.errorMessage != nil)
    }
}
