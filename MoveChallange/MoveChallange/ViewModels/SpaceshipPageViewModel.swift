//
//  SpaceshipPage.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class SpaceshipPageViewModel {
    var count: Int = 0
    var hasNext: Bool = true
    var hasPrevious: Bool = false
    var spaceships: [Spaceship] = []
    var searchCriteria: String = ""

    var currentPage = 0

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchSpaceshipUseCase: FetchSpaceshipPageUseCaseProtocol
    @ObservationIgnored var searchTextSubject = CurrentValueSubject<String, Never>("")
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []

    init(fetchSpaceshipUseCase: FetchSpaceshipPageUseCaseProtocol) {
        self.fetchSpaceshipUseCase = fetchSpaceshipUseCase
    }

    func fetchSpaceships() async {
        guard hasNext else { return }
        isLoading = true
        errorMessage = nil

        do {
            currentPage += 1
            let spaceshipPage = try await fetchSpaceshipUseCase.execute(for: currentPage)
            spaceships.append(contentsOf: spaceshipPage.results)
            hasNext = spaceshipPage.hasNext
            hasPrevious = spaceshipPage.hasPrevious
            count = spaceshipPage.count
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
