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
                //SearchBar(text: $viewModel.searchText)
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
                                    .clipped()
                            }
                        }
                        .padding()
                        .animation(.easeInOut, value: viewModel.animes)
                    }
                }
            }
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
