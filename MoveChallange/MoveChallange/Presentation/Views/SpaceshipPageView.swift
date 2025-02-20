//
//  SpaceshipPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct SpaceshipPageView: View {

    @State private var viewModel: SpaceshipPageViewModel

    init(viewModel: SpaceshipPageViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            VStack {
                //            SearchBoxView(text: <#T##Binding<String>#>, animation: <#T##Namespace.ID#>)
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
        .task {
            if viewModel.spaceships.isEmpty {
                await viewModel.fetchSpaceships()
            }
        }
    }
}
