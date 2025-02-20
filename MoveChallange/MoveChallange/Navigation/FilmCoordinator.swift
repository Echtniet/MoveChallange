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
    var path: NavigationPath = .init()

    @ObservationIgnored private let fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol

    init(fetchFilmPageUseCase: FetchFilmPageUseCaseProtocol) {
        self.fetchFilmPageUseCase = fetchFilmPageUseCase
    }

    func navigateToDetail(film: Film) {

    }
}
