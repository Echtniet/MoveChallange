//
//  CharaterDetailViewModel.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class CharacterDetailViewModel {
    @ObservationIgnored var character: StarCharacter!

    var spaceships: [Spaceship] = []
    var films: [Film] = []
    var firstLoad: Bool = true

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let fetchSpaceshipByIdUseCase: FetchSpaceshipByIdUseCaseProtocol
    @ObservationIgnored private let fetchFilmByIdUseCase: FetchFilmByIdUseCaseProtocol
    @ObservationIgnored private let favoriteCharacterUseCase: FavoriteCharacterUseCaseProtocol

    init(
        fetchSpaceshipByIdUseCase: FetchSpaceshipByIdUseCaseProtocol,
        fetchFilmByIdUseCase: FetchFilmByIdUseCaseProtocol,
        favoriteCharacterUseCase: FavoriteCharacterUseCaseProtocol
    ) {
        self.fetchSpaceshipByIdUseCase = fetchSpaceshipByIdUseCase
        self.fetchFilmByIdUseCase = fetchFilmByIdUseCase
        self.favoriteCharacterUseCase = favoriteCharacterUseCase
    }

    func fetchSpaceships() async {
        do {
            spaceships = try await fetchSpaceshipByIdUseCase.execute(urlStrings: character.starships)
        } catch {
            errorMessage = errorMessage == nil ? "Error: \(error.localizedDescription)" : errorMessage! + " \(error.localizedDescription)"
        }
    }

    func fetchFilms() async {
        do {
            films = try await fetchFilmByIdUseCase.execute(urlStrings: character.films)
        } catch {
            errorMessage = errorMessage == nil ? "Error: \(error.localizedDescription)" : errorMessage! + " \(error.localizedDescription)"
        }
    }

    func fetchAll() async {
        guard firstLoad else { return }

        isLoading = true
        errorMessage = nil

        await fetchSpaceships()
        await fetchFilms()

        isLoading = false
        firstLoad = false
    }
    
    @MainActor
    func makeFavorite() {
        favoriteCharacterUseCase.executeSaveFavorite(character: character)
    }
}
