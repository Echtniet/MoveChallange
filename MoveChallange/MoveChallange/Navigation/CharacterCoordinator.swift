//
//  CharacterCoordinator.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Observation
import SwiftUI

@Observable
class CharacterCoordinator {
    var path: [AppRoute] = []

    @ObservationIgnored private let fetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol

    init(fetchCharacterPageUseCase: FetchCharacterPageUseCaseProtocol) {
        self.fetchCharacterPageUseCase = fetchCharacterPageUseCase
    }

    func navigateToDetail(character: StarCharacter) {
        path.append(AppRoute.characterDetail(character))
        print(path)
    }
}
