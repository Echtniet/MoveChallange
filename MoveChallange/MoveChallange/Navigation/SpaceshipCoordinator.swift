//
//  SpaceshipCoordinator.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Observation
import SwiftUI

@Observable
class SpaceshipCoordinator {
    var path: [AppRoute] = []

    @ObservationIgnored private let fetchSpaceshipPageUseCase: FetchSpaceshipPageUseCaseProtocol

    init(fetchSpaceshipPageUseCase: FetchSpaceshipPageUseCaseProtocol) {
        self.fetchSpaceshipPageUseCase = fetchSpaceshipPageUseCase
    }

    func navigateToDetail(spaceship: Spaceship, shouldClearPath: Bool = false) {
        if shouldClearPath {
            path.removeAll()
        }
        path.append(.spaceshipDetail(spaceship))
    }
}
