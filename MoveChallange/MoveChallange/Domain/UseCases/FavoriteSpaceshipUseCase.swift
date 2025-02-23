//
//  FavoriteSpaceshipUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 22/02/2025.
//

import Foundation

@MainActor
protocol FavoriteSpaceshipUseCaseProtocol {
    func executeSaveSpaceship(spaceship: Spaceship)
    func executeRemoveSpaceship(character: SpaceshipDataModel)
    func executeGetFavoriteSpaceships() -> [SpaceshipDataModel]
}

@MainActor
class FavoriteSpaceshipUseCase: FavoriteSpaceshipUseCaseProtocol {
    private let repository: FavoriteStorageProtocol

    init(repository: FavoriteStorageProtocol) {
        self.repository = repository
    }

    func executeSaveSpaceship(spaceship: Spaceship) {
        self.repository.saveFavorite(spaceship: spaceship)
    }
    
    func executeRemoveSpaceship(character: SpaceshipDataModel) {
        self.repository.removeFavorite(spaceship: character)
    }
    
    func executeGetFavoriteSpaceships() -> [SpaceshipDataModel] {
        self.repository.getFavoriteSpaceships()
    }
}
