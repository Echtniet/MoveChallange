//
//  AppView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct AppView: View {
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
                    viewModel: DIContainer.shared.resolve(CharacterPageViewModel.self),
                    coordinator: DIContainer.shared.resolve(CharacterCoordinator.self)
                )
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .characterDetail(let character):
                        Text("\(character.name)")
                    default:
                        EmptyView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Characters")
            }
            .tag(AppCoordinator.Tab.characters)

            NavigationStack(path: $coordinator.filmCoordinator.path) {
                FilmPageView(viewModel: DIContainer.shared.resolve(FilmPageViewModel.self))
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .filmDetail(let film):
                            EmptyView()
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Films")
            }
            .tag(AppCoordinator.Tab.films)

            NavigationStack(path: $coordinator.spaceshipCoordinator.path) {
                SpaceshipPageView(viewModel: DIContainer.shared.resolve(SpaceshipPageViewModel.self))
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .spaceshipDetail(let spaceship):
                            EmptyView()
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Spaceships")
            }
            .tag(AppCoordinator.Tab.spaceships)

//            NavigationStack(path: $coordinator.favoriteCoordinator.path) {
//                SpaceshipPageView(viewModel: DIContainer.shared.resolve(SpaceshipPageViewModel.self))
//                    .navigationDestination(for: AppRoute.self) { route in
//                        switch route {
//                        case .spaceshipDetail(let spaceship):
//                            EmptyView()
//                        default:
//                            EmptyView()
//                        }
//                    }
//            }
//            .tabItem {
//                Image(systemName: "person.crop.circle")
//                Text("Favorites")
//            }
//            .tag(AppCoordinator.Tab.favorites)
        }
        .tint(tabColor(for: coordinator.selectedTab))
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
