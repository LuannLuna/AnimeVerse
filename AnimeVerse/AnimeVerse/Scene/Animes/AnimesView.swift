import SwiftUI

struct AnimesView: View {
    @Environment(Router.self) private var router: Router
    @State private var viewModel = AnimesViewModel()
    @State private var isSearchPresented = false
    @State private var selectedSort: MediaSort = .scoreDesc

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
                        .refreshable {
                            await viewModel.refresh()
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
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("Trending Now") { selectedSort = .trendingDesc; Task { await viewModel.changeSort(selectedSort) } }
                        Button("Most Popular") { selectedSort = .popularityDesc; Task { await viewModel.changeSort(selectedSort) } }
                        Button("Top Rated") { selectedSort = .scoreDesc; Task { await viewModel.changeSort(selectedSort) } }
                    } label: {
                        Label(selectedSort.displayName, systemImage: "arrow.up.arrow.down")
                    }
                }
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
                    SearchView(router: router, mediaKind: .anime, isPresented: $isSearchPresented)
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
    AnimesView()
        .environment(Router())
}
