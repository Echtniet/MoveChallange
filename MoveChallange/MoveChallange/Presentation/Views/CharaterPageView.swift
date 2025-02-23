//
//  CharaterPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct CharacterPageView: View {
    var namespace: Namespace.ID

    @State private var viewModel: CharacterPageViewModel
    @Binding private var coordinator: CharacterCoordinator

    init(_ namespace: Namespace.ID, viewModel: CharacterPageViewModel, coordinator: Binding<CharacterCoordinator>) {
        self.namespace = namespace
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = coordinator
    }

    var body: some View {
        ZStack {
            VStack {
                SearchBoxView(text: $viewModel.searchCriteria, animation: namespace, color: .red)
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if viewModel.errorMessage != nil {
                            Text("\(viewModel.errorMessage!)")
                        } else if viewModel.isLoading && viewModel.characters.isEmpty {
                            Text("Loading...")
                        } else {
                            ForEach(viewModel.characters, id: \.self) { char in
                                Card(title: char.name, subtitle: char.homeworld) {

                                }
                                .onTapGesture {
                                    coordinator.navigateToDetail(character: char)
                                }
                                .cardStyle(char.cardStyle)
                                .onAppear {
                                    if char == viewModel.characters.last {
                                        Task { await viewModel.fetchCharacters() }
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
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    }
}
