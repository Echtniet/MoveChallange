//
//  FavoriteCharacterUseCase.swift
//  MoveChallange
//
//  Created by Clinton on 22/02/2025.
//

import Foundation

@MainActor
protocol FavoriteCharacterUseCaseProtocol {
    func executeSaveFavorite(character: StarCharacter)
    func executeRemoveFavorite(character: StarCharacterDataModel)
    func executeGetFavoriteCharacters() -> [StarCharacterDataModel]
}

@MainActor
class FavoriteCharacterUseCase: FavoriteCharacterUseCaseProtocol {
    private let repository: FavoriteStorageProtocol

    init(repository: FavoriteStorageProtocol) {
        self.repository = repository
    }

    func executeSaveFavorite(character: StarCharacter) {
        self.repository.saveFavorite(character: character)
    }

    func executeRemoveFavorite(character: StarCharacterDataModel) {
        self.repository.removeFavorite(character: character)
    }
    
        
    func executeGetFavoriteCharacters() -> [StarCharacterDataModel] {
        self.repository.getFavoriteCharacters()
    }
}
