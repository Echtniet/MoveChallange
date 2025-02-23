//
//  SpaceshipPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct SpaceshipPageView: View {
    var namespace: Namespace.ID

    @State private var viewModel: SpaceshipPageViewModel
    @Binding private var coordinator: SpaceshipCoordinator

    init(_ namespace: Namespace.ID, viewModel: SpaceshipPageViewModel, coordinator: Binding<SpaceshipCoordinator>) {
        self.namespace = namespace
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = coordinator
    }

    var body: some View {
        ZStack {
            VStack {
                SearchBoxView(text: $viewModel.searchCriteria, animation: namespace, color: .white, searchBoxStyle: .spaceship)
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if viewModel.errorMessage != nil {
                            Text("\(viewModel.errorMessage!)")
                        } else if viewModel.isLoading && viewModel.spaceships.isEmpty {
                            Text("Loading...")
                        } else {
                            ForEach(viewModel.spaceships, id: \.self) { spaceship in
                                Card(title: spaceship.name, subtitle: spaceship.cargoCapacity) {

                                }
                                .onTapGesture {
                                    coordinator.navigateToDetail(spaceship: spaceship)
                                }
                                .cardStyle(spaceship.cardStyle)
                                .onAppear {
                                    if spaceship == viewModel.spaceships.last {
                                        Task { await viewModel.fetchSpaceships() }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: viewModel.searchCriteria) { _, new in
            viewModel.searchTextSubject.send(new)
        }
        .task {
            if viewModel.spaceships.isEmpty {
                await viewModel.fetchSpaceships()
            }
        }
    }
}
