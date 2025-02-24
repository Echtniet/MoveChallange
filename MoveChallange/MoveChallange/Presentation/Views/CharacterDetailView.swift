//
//  CharacterDetailView.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct CharacterDetailView: View {
    var namespace: Namespace.ID

    @State private var viewModel: CharacterDetailViewModel
    @State private var coordinator: AppCoordinator

    init(_ namespace: Namespace.ID, character: StarCharacter, viewModel: CharacterDetailViewModel, coordinator: AppCoordinator) {
        self.namespace = namespace
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = State(wrappedValue: coordinator)
        viewModel.character = character
    }

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Character Name: \(viewModel.character.name)")
                Spacer()
                Button {
                    viewModel.makeFavorite()
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(.red)
                }
            }

            if !viewModel.spaceships.isEmpty {
                ExpandableListView(title: "Spaceships", items: viewModel.spaceships) { spaceship in
                    Text(spaceship.name)
                        .onTapGesture {
                            coordinator.navigate(to: .spaceshipDetail(spaceship))
                        }
                }
                .padding()
                .sith()
            }

            if !viewModel.films.isEmpty {
                ExpandableListView(title: "Films", items: viewModel.films) { film in
                    Text(film.title)
                        .onTapGesture {
                            coordinator.navigate(to: .filmDetail(film))
                        }
                }
                .padding()
                .sith()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            await viewModel.fetchAll()
        }
    }
}
