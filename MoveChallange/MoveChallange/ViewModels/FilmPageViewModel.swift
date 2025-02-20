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

    var currentPage = 0

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol
    @ObservationIgnored var searchTextSubject = CurrentValueSubject<String, Never>("")
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []

    init(fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol) {
        self.fetchFilmPageUseCase = fetchFilmPageUseCase
    }

    func fetchFilms() async {
        guard hasNext else { return }
        isLoading = true
        errorMessage = nil

        do {
            currentPage += 1
            let filmPage = try await fetchFilmPageUseCase.execute(for: currentPage)
            films.append(contentsOf: filmPage.results)
            hasNext = filmPage.hasNext
            hasPrevious = filmPage.hasPrevious
            count = filmPage.count
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
