//
//  FavoriteFilmUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 22/02/2025.
//

import Foundation

@MainActor
protocol FavoriteFilmUseCaseProtocol {
    func executeSaveFavorite(film: Film)
    func executeRemoveFavorite(film: FilmDataModel)
    func executeGetFavoriteFilms() -> [FilmDataModel]
}

@MainActor
class FavoriteFilmUseCase: FavoriteFilmUseCaseProtocol {

    private let repository: FavoriteStorageProtocol

    init(repository: FavoriteStorageProtocol) {
        self.repository = repository
    }

    func executeSaveFavorite(film: Film) {
        self.repository.saveFavorite(film: film)
    }
    
    func executeRemoveFavorite(film: FilmDataModel) {
        self.repository.removeFavorite(film: film)
    }
    
    func executeGetFavoriteFilms() -> [FilmDataModel] {
        self.repository.getFavoriteFilms()
    }
}
