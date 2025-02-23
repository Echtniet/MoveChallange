//
//  AppView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct AppView: View {
    @Namespace private var animation
    @State private var coordinator: AppCoordinator

    init() {
        let diContainer = DIContainer.shared
        _coordinator = State(wrappedValue: diContainer.resolve(AppCoordinator.self))
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack(path: $coordinator.characterCoordinator.path) {
                CharacterPageView(
                    animation, viewModel: DIContainer.shared.resolve(CharacterPageViewModel.self),
                    coordinator: $coordinator.characterCoordinator
                )
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .characterDetail(let character):
                        CharacterDetailView(
                            animation,
                            character: character,
                            viewModel: DIContainer.shared.resolve(CharacterDetailViewModel.self)
                        )
                    default:
                        EmptyView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "person")
                Text("Characters")
            }
            .tag(AppCoordinator.Tab.characters)

            NavigationStack(path: $coordinator.filmCoordinator.path) {
                FilmPageView(
                    animation,
                    viewModel: DIContainer.shared.resolve(FilmPageViewModel.self),
                    coordinator: $coordinator.filmCoordinator
                )
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .filmDetail(let film):
                        FilmDetailView(
                            animation,
                            film: film,
                            viewModel: DIContainer.shared.resolve(FilmDetailViewModel.self)
                        )
                    default:
                        EmptyView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "popcorn")
                Text("Films")
            }
            .tag(AppCoordinator.Tab.films)

            NavigationStack(path: $coordinator.spaceshipCoordinator.path) {
                SpaceshipPageView(
                    animation,
                    viewModel: DIContainer.shared.resolve(SpaceshipPageViewModel.self),
                    coordinator: $coordinator.spaceshipCoordinator
                )
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .spaceshipDetail(let spaceship):
                        SpaceshipDetailView(
                            animation,
                            spaceship: spaceship,
                            viewModel: DIContainer.shared.resolve(SpaceshipDetailViewModel.self))
                    default:
                        EmptyView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Spaceships")
            }
            .tag(AppCoordinator.Tab.spaceships)

            NavigationStack(path: $coordinator.favoriteCoordinator.path) {
                FavoritesPageView(
                    animation,
                    viewModel: DIContainer.shared.resolve(FavoritesPageViewModel.self)
                )
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            .tag(AppCoordinator.Tab.favorites)
        }
        .tint(tabColor(for: coordinator.selectedTab))
        .environment(coordinator)
    }

    func tabColor(for tab: AppCoordinator.Tab) -> Color {
        switch tab {
        case .films: return .blue   // Planet theme
        case .spaceships: return .white  // Spaceship theme
        case .characters: return .red    // Sith theme
        default: return .gray
        }
    }
}
