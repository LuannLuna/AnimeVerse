//
//  HomeView.swift
//  AnimeVerse
//
//  Created by Luann Luna on 23/04/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Carregando animes...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.animes, id: \.id) { anime in
                                AnimeCardView(anime: anime)
                                    .onAppear {
                                        Task {
                                            await viewModel.loadNextPageIfNeeded(item: anime)
                                        }
                                    }
                            }
                        }
                        .padding()
                        .animation(.easeInOut, value: viewModel.animes)
                    }
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always) ,
                prompt: "Search"
            )
            .navigationTitle("Animes")
        }
        .task {
            await viewModel.loadAnimes()
        }
    }
}

#Preview {
    HomeView()
}
