//
//  FilmDetailView.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct FilmDetailView: View {
    var namespace: Namespace.ID

    @Environment(AppCoordinator.self) var coordinator
    @State private var viewModel: FilmDetailViewModel

    init(_ namespace: Namespace.ID, film: Film, viewModel: FilmDetailViewModel) {
        self.namespace = namespace
       _viewModel = State(wrappedValue: viewModel)
        viewModel.film = film
    }

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Film Title: \(viewModel.film.title)")
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
                .atmosphere()
            }

            if !viewModel.characters.isEmpty {
                ExpandableListView(title: "Characters", items: viewModel.characters) { character in
                    Text(character.name)
                        .onTapGesture {
                            coordinator.navigate(to: .characterDetail(character))
                        }
                }
                .padding()
                .atmosphere()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .atmosphere()
        .task {
            await viewModel.fetchAll()
        }
    }
}
