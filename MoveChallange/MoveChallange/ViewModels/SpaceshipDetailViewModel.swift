//
//  SpaceshipDetailViewModel.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class SpaceshipDetailViewModel {
    @ObservationIgnored var spaceship: Spaceship!

    var films: [Film] = []
    var firstLoad: Bool = true

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchFilmByIdUseCase: FetchFilmByIdUseCaseProtocol
    @ObservationIgnored private let favoriteSpaceshipUseCase: FavoriteSpaceshipUseCaseProtocol

    init(
        fetchFilmByIdUseCase: FetchFilmByIdUseCaseProtocol,
        favoriteSpaceshipUseCase: FavoriteSpaceshipUseCaseProtocol
    ) {
        self.fetchFilmByIdUseCase = fetchFilmByIdUseCase
        self.favoriteSpaceshipUseCase = favoriteSpaceshipUseCase
    }
    
    func fetchFilms() async {
        guard firstLoad else { return }

        isLoading = true
        errorMessage = nil

        do {
            films = try await fetchFilmByIdUseCase.execute(urlStrings: spaceship.films)
        } catch {
            errorMessage = errorMessage == nil ? "Error: \(error.localizedDescription)" : errorMessage! + " \(error.localizedDescription)"
        }

        isLoading = false
        firstLoad = false
    }

    @MainActor
    func makeFavorite() {
        favoriteSpaceshipUseCase.executeSaveSpaceship(spaceship: spaceship)
    }
}
