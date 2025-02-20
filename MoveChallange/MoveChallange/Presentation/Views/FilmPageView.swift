//
//  FilmPageView.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//


import SwiftUI

struct FilmPageView: View {

    @State private var viewModel: FilmPageViewModel

    init(viewModel: FilmPageViewModel) {
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
                        } else if viewModel.isLoading && viewModel.films.isEmpty {
                            Text("Loading...")
                        } else {
                            ForEach(viewModel.films, id: \.self) { film in
                                Card(title: film.title, subtitle: film.director) {

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
        .task {
            if viewModel.films.isEmpty {
                await viewModel.fetchFilms()
            }
        }
    }
}
