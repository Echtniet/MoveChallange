//
//  FilmPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//


import SwiftUI

struct FilmPageView: View {
    var namespace: Namespace.ID

    @State private var viewModel: FilmPageViewModel
    @Binding private var coordinator: FilmCoordinator

    init(_ namespace: Namespace.ID, viewModel: FilmPageViewModel, coordinator: Binding<FilmCoordinator>) {
        self.namespace = namespace
        _viewModel = State(wrappedValue: viewModel)
        _coordinator = coordinator
    }

    var body: some View {
        ZStack {
            VStack {
                SearchBoxView(text: $viewModel.searchCriteria, animation: namespace, color: .blue, searchBoxStyle: .film)
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if viewModel.errorMessage != nil {
                            Text("\(viewModel.errorMessage!)")
                        } else if viewModel.isLoading && viewModel.films.isEmpty {
                            Text("Loading...")
                        } else {
                            ForEach(viewModel.films, id: \.self) { film in
                                Card(title: film.title, subtitle: film.director) {

                                }
                                .onTapGesture {
                                    coordinator.navigateToDetail(film: film)
                                }
                                .cardStyle(film.cardStyle)
                                .onAppear {
                                    if film == viewModel.films.last {
                                        Task { await viewModel.fetchFilms() }
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
            if viewModel.films.isEmpty {
                await viewModel.fetchFilms()
            }
        }
    }
}
