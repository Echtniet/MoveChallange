//
//  CharaterPageViewModel.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class CharacterPageViewModel {
    var count: Int = 0
    var hasNext: Bool = true
    var hasPrevious: Bool = false
    var characters: [StarCharacter] = []
    var filteredCharacters: [StarCharacter] = []
    var searchCriteria: String = ""
    var selectedGender: StarCharacter.Gender? = nil

    var currentPage = 0

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol
    @ObservationIgnored private let filterCharacterGenderUseCase: FilterCharacterGenderUseCaseProtocol
    @ObservationIgnored var searchTextSubject = CurrentValueSubject<String, Never>("")
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []

    init(
        fetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol,
        filterCharacterGenderUseCase: FilterCharacterGenderUseCaseProtocol
    ) {
        self.fetchCharacterPageUseCase = fetchCharacterPageUseCase
        self.filterCharacterGenderUseCase = filterCharacterGenderUseCase
    }

    func fetchCharacters() async {
        guard hasNext else { return }
        isLoading = true
        errorMessage = nil
        do {
            currentPage += 1
            let characterPage = try await fetchCharacterPageUseCase.execute(for: currentPage)
            characters.append(contentsOf: characterPage.results)
            hasNext = characterPage.hasNext
            hasPrevious = characterPage.hasPrevious
            count = characterPage.count
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func applyFilter() {
        var tempCharacters = characters

        if let selectedGender {
            tempCharacters = filterCharacterGenderUseCase.execute(characters: tempCharacters, on: selectedGender)
        }

        filteredCharacters = tempCharacters
    }
}
