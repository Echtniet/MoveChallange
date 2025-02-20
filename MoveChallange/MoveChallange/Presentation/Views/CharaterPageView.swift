//
//  CharaterPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct CharacterPageView: View {

    @State private var viewModel: CharacterPageViewModel
    @State private var coordinator: CharacterCoordinator

    init(viewModel: CharacterPageViewModel, coordinator: CharacterCoordinator) {
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = State(wrappedValue: coordinator)
    }

    var body: some View {
        ZStack {
            VStack {
                //            SearchBoxView(text: <#T##Binding<String>#>, animation: <#T##Namespace.ID#>)
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if viewModel.errorMessage != nil {
                            Text("\(viewModel.errorMessage!)")
                        } else if viewModel.isLoading && viewModel.characters.isEmpty {
                            Text("Loading...")
                        } else {
                            ForEach(viewModel.characters, id: \.self) { char in
                                Card(title: char.name, subtitle: char.homeworld) {
//                                    coordinator.navigateToDetail(character: char)
//                                    print(char.name)
                                }
                                .onTapGesture {
                                    print("adsa")
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
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    }
}
