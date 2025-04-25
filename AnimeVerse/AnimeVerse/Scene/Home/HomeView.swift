import SwiftUI

struct HomeView: View {
    @Bindable var router: Router
    @State private var viewModel = HomeViewModel()
    @State private var isSearchPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let errorMessage = viewModel.errorMessage {
                        Text("Erro: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.animes, id: \.id) { anime in
                                    Button {
                                        withAnimation(.easeInOut) {
                                            router.navigate(to: .details(animeId: anime.id), using: .push)
                                        }
                                    } label: {
                                        AnimeCardView(anime: anime)
                                    }
                                    .task {
                                        await viewModel.loadNextPageIfNeeded(item: anime)
                                    }
                                }
                            }
                            .padding()
                            .animation(.easeInOut, value: viewModel.animes)
                        }
                    }
                }

                if viewModel.isLoading {
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ProgressView("Carregando animes...")
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSearchPresented = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(
                isPresented: $isSearchPresented,
                content: {
                    AnimeSearchView(router: router, isPresented: $isSearchPresented)
                }
            )
            .navigationTitle("Animes")
        }
        .task {
            await viewModel.loadAnimes()
        }
    }
}

#Preview {
    HomeView(router: .init())
}
