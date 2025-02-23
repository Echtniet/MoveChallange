//
//  FilmPageViewModel.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class FilmPageViewModel {
    var count: Int = 0
    var hasNext: Bool = true
    var hasPrevious: Bool = false
    var films: [Film] = []
    var searchCriteria: String = ""
    var firstLoad: Bool = true

    var currentPage = 0

    var isLoading: Bool = false
    var errorMessage: String?

    var searchTask: Task<Void, Never>?

    @ObservationIgnored private let fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol
    @ObservationIgnored var searchTextSubject = CurrentValueSubject<String, Never>("")
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []

    init(fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol) {
        self.fetchFilmPageUseCase = fetchFilmPageUseCase
        setupDebouncingSearchFetch()
    }

    func fetchFilms() async {
        guard hasNext else { return }
        isLoading = true
        errorMessage = nil

        do {
            currentPage += 1
            let filmPage = try await fetchFilmPageUseCase.execute(for: currentPage, search: searchCriteria)
            films.append(contentsOf: filmPage.results)
            hasNext = filmPage.hasNext
            hasPrevious = filmPage.hasPrevious
            count = filmPage.count
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
        firstLoad = false
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
        films.removeAll()
        hasNext = true
        hasPrevious = false
        await fetchFilms()
    }
}
