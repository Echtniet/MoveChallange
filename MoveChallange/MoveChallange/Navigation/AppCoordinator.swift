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
    var navigationPath: [Tab] = []
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
            navigationPath.append(selectedTab)
            selectedTab = .characters
        case .characterDetail(let character):
            navigationPath.append(selectedTab)
            selectedTab = .characters
            characterCoordinator.navigateToDetail(character: character, shouldClearPath: true)
        case .filmPage:
            navigationPath.append(selectedTab)
            selectedTab = .films
        case .filmDetail(let film):
            navigationPath.append(selectedTab)
            selectedTab = .films
            filmCoordinator.navigateToDetail(film: film, shouldClearPath: true)
        case .spaceshipPage:
            navigationPath.append(selectedTab)
            selectedTab = .spaceships
        case .spaceshipDetail(let spaceship):
            navigationPath.append(selectedTab)
            selectedTab = .spaceships
            spaceshipCoordinator.navigateToDetail(spaceship: spaceship, shouldClearPath: true)
        case .favoritePage:
            navigationPath.append(selectedTab)
            selectedTab = .favorites
        }
    }

    func back() {
        let oldTab = selectedTab
        if let lastTab = self.navigationPath.popLast() {
            self.selectedTab = lastTab
        }
        switch oldTab {
        case .characters:
            characterCoordinator.back()
        case .films:
            filmCoordinator.back()
        case .spaceships:
            spaceshipCoordinator.back()
        case .favorites:
            favoriteCoordinator.back()
        }
    }
}
