//
//  SpaceshipDetailView.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct SpaceshipDetailView: View {
    var namespace: Namespace.ID

    @Environment(AppCoordinator.self) var coordinator
    @State private var viewModel: SpaceshipDetailViewModel

    init(_ namespace: Namespace.ID, spaceship: Spaceship, viewModel: SpaceshipDetailViewModel) {
        self.namespace = namespace
       _viewModel = State(wrappedValue: viewModel)
        viewModel.spaceship = spaceship
    }

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Spaceship Name \(viewModel.spaceship.name)")
                Spacer()
                Button {
                    viewModel.makeFavorite()
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(.red)
                }
            }
            if !viewModel.films.isEmpty {
                ExpandableListView(title: "Films", items: viewModel.films) { film in
                    Text(film.title)
                        .onTapGesture {
                            coordinator.navigate(to: .filmDetail(film))
                        }
                }
                .padding()
                .spaceship()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .spaceship()
        .task {
            await viewModel.fetchFilms()
        }
    }
}
