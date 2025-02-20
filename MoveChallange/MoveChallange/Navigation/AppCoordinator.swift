//
//  AppCoordinator.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import Observation
import SwiftUI

enum AppRoute: Hashable {
    case characterPage
    case characterDetail(StarCharacter)
    case filmPage
    case filmDetail(Film)
    case spaceshipPage
    case spaceshipDetail(Spaceship)
    case favoritePage
}

@Observable
final class AppCoordinator {
    var selectedTab: Tab = .characters
    var currentRoute: AppRoute = .characterPage
    var characterCoordinator: CharacterCoordinator
    var filmCoordinator: FilmCoordinator
    var spaceshipCoordinator: SpaceshipCoordinator
    var favoriteCoordinator: FavoriteCoordinator

    enum Tab {
        case characters, films, spaceships, favorites
    }

    init(
        characterCoordinator: CharacterCoordinator,
        filmCoordinator: FilmCoordinator,
        spaceshipCoordinator: SpaceshipCoordinator,
        favoriteCoordinator: FavoriteCoordinator
    ) {
        self.characterCoordinator = characterCoordinator
        self.filmCoordinator = filmCoordinator
        self.spaceshipCoordinator = spaceshipCoordinator
        self.favoriteCoordinator = favoriteCoordinator
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .characterPage:
            selectedTab = .characters
        case .characterDetail(let character):
            selectedTab = .characters
            characterCoordinator.navigateToDetail(character: character)
        case .filmPage:
            selectedTab = .films
        case .filmDetail(let film):
            selectedTab = .films
            filmCoordinator.navigateToDetail(film: film)
        case .spaceshipPage:
            selectedTab = .spaceships
        case .spaceshipDetail(let spaceship):
            selectedTab = .spaceships
            spaceshipCoordinator.navigateToDetail(spaceship: spaceship)
        case .favoritePage:
            selectedTab = .favorites
        }
    }
}
