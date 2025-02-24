//
//  FilmCoordinator.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Observation
import SwiftUI

@Observable
class FilmCoordinator {
    var path: [AppRoute] = []

    @ObservationIgnored private let fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol

    init(fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol) {
        self.fetchFilmPageUseCase = fetchFilmPageUseCase
    }

    func back() {
        path.removeLast()
    }

    func navigateToDetail(film: Film, shouldClearPath: Bool = false) {
        if shouldClearPath {
//            path.removeAll()
        }
        path.append(AppRoute.filmDetail(film))
    }
}
