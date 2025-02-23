//
//  FilmDetailViewDetail.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class FilmDetailViewModel {
    @ObservationIgnored var film: Film!

    var spaceships: [Spaceship] = []
    var characters: [StarCharacter] = []
    var firstLoad: Bool = true

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchSpaceshipByIdUseCase: FetchSpaceshipByIdUseCaseProtocol
    @ObservationIgnored private let fetchCharacterByIdUseCase: FetchCharacterByIdUseCaseProtocol
    @ObservationIgnored private let favortieFilmUseCase: FavoriteFilmUseCaseProtocol

    init(
        fetchSpaceshipByIdUseCase: FetchSpaceshipByIdUseCaseProtocol,
        fetchCharacterByIdUseCase: FetchCharacterByIdUseCaseProtocol,
        favortieFilmUseCase: FavoriteFilmUseCaseProtocol
    ) {
        self.fetchSpaceshipByIdUseCase = fetchSpaceshipByIdUseCase
        self.fetchCharacterByIdUseCase = fetchCharacterByIdUseCase
        self.favortieFilmUseCase = favortieFilmUseCase
    }

    func fetchSpaceships() async {
        do {
            spaceships = try await fetchSpaceshipByIdUseCase.execute(urlStrings: film.starships)
        } catch {
            errorMessage = errorMessage == nil ? "Error: \(error.localizedDescription)" : errorMessage! + " \(error.localizedDescription)"
        }
    }

    func fetchCharacters() async {
        do {
            characters = try await fetchCharacterByIdUseCase.execute(urlStrings: film.characters)
        } catch {
            errorMessage = errorMessage == nil ? "Error: \(error.localizedDescription)" : errorMessage! + " \(error.localizedDescription)"
        }
    }

    func fetchAll() async {
        guard firstLoad else { return }

        isLoading = true
        errorMessage = nil

        await fetchSpaceships()
        await fetchCharacters()

        isLoading = false
        firstLoad = false
    }

    @MainActor
    func makeFavorite() {
        favortieFilmUseCase.executeSaveFavorite(film: film)
    }
}
