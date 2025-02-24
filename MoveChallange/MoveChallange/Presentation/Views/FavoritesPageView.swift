//
//  FavoritesPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct FavoritesPageView: View {

    var namespace: Namespace.ID

    @State private var viewModel: FavoritesPageViewModel
    @State private var coordinator: AppCoordinator

    init(_ namespace: Namespace.ID, viewModel: FavoritesPageViewModel, coordinator: AppCoordinator) {
        self.namespace = namespace
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = State(wrappedValue: coordinator)
    }

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    if viewModel.errorMessage != nil {
                        Text("\(viewModel.errorMessage!)")
                    } else if viewModel.isLoading && viewModel.favorites.isEmpty {
                        Text("Loading...")
                    } else {
                        ForEach(viewModel.favorites, id: \.id) { favorite in
                            Group {
                                switch favorite {
                                case let character as StarCharacterDataModel:
                                    Card(title: character.name, subtitle: character.homeworld) {

                                    }
                                    .onTapGesture {
                                        coordinator.navigate(to: .characterDetail(StarCharacter(model: character)))
                                    }
                                case let film as FilmDataModel:
                                    Card(title: film.title, subtitle: film.director) {

                                    }
                                    .onTapGesture {
                                        coordinator.navigate(to: .filmDetail(Film(model: film)))
                                    }
                                case let spaceship as SpaceshipDataModel:
                                    Card(title: spaceship.name, subtitle: spaceship.costInCredits) {

                                    }
                                    .onTapGesture {
                                        coordinator.navigate(to: .spaceshipDetail(Spaceship(model: spaceship)))
                                    }
                                default:
                                    EmptyView()
                                }
                            }
                            .cardStyle(favorite.cardStyle)
                        }
                    }
                }
                .padding()
            }
            .refreshable {
                viewModel.fetchFavorites()
            }
        }
        .task {
            if viewModel.firstLoad {
                viewModel.fetchFavorites()
            }
        }
    }
}
