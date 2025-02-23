//
//  FavoritesPageViewModel.swift
//  MoveChallange
//
//  Created by Clinton on 23/02/2025.
//

import Combine
import Observation
import SwiftUI

@Observable
class FavoritesPageViewModel {

    var favorites: [FavoritesDataModelProtocol] = []
    var firstLoad: Bool = true

    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let favoriteCharacterUseCase: FavoriteCharacterUseCaseProtocol
    @ObservationIgnored private let favoriteFilmUseCase: FavoriteFilmUseCaseProtocol
    @ObservationIgnored private let favoriteSpaceShipUseCase: FavoriteSpaceshipUseCaseProtocol

    init(
        favoriteCharacterUseCase: FavoriteCharacterUseCaseProtocol,
        favoriteFilmUseCase: FavoriteFilmUseCaseProtocol,
        favoriteSpaceShipUseCase: FavoriteSpaceshipUseCaseProtocol
    ) {
        self.favoriteCharacterUseCase = favoriteCharacterUseCase
        self.favoriteFilmUseCase = favoriteFilmUseCase
        self.favoriteSpaceShipUseCase = favoriteSpaceShipUseCase
    }

    @MainActor
    func fetchFavorites() {
        isLoading = true
        errorMessage = nil
        favorites = []
        favorites.append(contentsOf: favoriteCharacterUseCase.executeGetFavoriteCharacters())
        favorites.append(contentsOf: favoriteFilmUseCase.executeGetFavoriteFilms())
        favorites.append(contentsOf: favoriteSpaceShipUseCase.executeGetFavoriteSpaceships())
        // mix up to simulate saved by date
        favorites.shuffle()
        isLoading = false
        firstLoad = false
    }
}
