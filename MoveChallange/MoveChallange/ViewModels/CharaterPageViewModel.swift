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
    var firstLoad: Bool = true

    var currentPage = 0

    var isLoading: Bool = false
    var errorMessage: String?

    var searchTask: Task<Void, Never>?

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
        setupDebouncingSearchFetch()
    }

    func fetchCharacters() async {
        guard hasNext else { return }
        isLoading = true
        errorMessage = nil
        do {
            currentPage += 1
            let characterPage = try await fetchCharacterPageUseCase.execute(for: currentPage, search: searchCriteria)
            characters.append(contentsOf: characterPage.results)
            hasNext = characterPage.hasNext
            hasPrevious = characterPage.hasPrevious
            count = characterPage.count
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
        firstLoad = false
    }

    func applyFilter() {
        var tempCharacters = characters

        if let selectedGender {
            tempCharacters = filterCharacterGenderUseCase.execute(characters: tempCharacters, on: selectedGender)
        }

        filteredCharacters = tempCharacters
    }

    private func setupDebouncingSearchFetch() {
        searchTextSubject
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let firstLoad = self?.firstLoad, !firstLoad else { return }
                self?.searchTask?.cancel()
                self?.searchTask = self?.createSearchTask(text)
            }
            .store(in: &cancellables)
    }

    private func createSearchTask(_ text: String) -> Task<Void, Never> {
        Task { @MainActor in
            await onSearchFetch()
        }
    }

    private func onSearchFetch() async {
        currentPage = 0
        characters.removeAll()
        hasNext = true
        hasPrevious = false
        await fetchCharacters()
    }
}
