import SwiftUI
import Kingfisher

struct AnimeSearchView: View {
    @Bindable var router: Router
    @State private var viewModel = AnimeSearchViewModel()
    @State private var searchTask: Task<Void, Never>?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.animes.isEmpty && !viewModel.isLoading {
                    ContentUnavailableView.search
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.animes) { anime in
                                AnimeSearchCard(anime: anime)
                                    .onTapGesture {
                                        isPresented = false
                                        router.navigate(to: .details(animeId: anime.id), using: .push)
                                    }
                                    .task {
                                        if anime.id == viewModel.animes.last?.id {
                                            await viewModel.loadMore()
                                        }
                                    }
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText) { _, newValue in
                searchTask?.cancel()
                searchTask = Task {
                    try? await Task.sleep(for: .milliseconds(300))
                    await viewModel.search()
                }
            }
        }
    }
}

private struct AnimeSearchCard: View {
    let anime: AnimeSearchResult
    
    var body: some View {
        HStack(spacing: 16) {
                KFImage(anime.coverImageURL)
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(anime.titleEnglish ?? anime.titleRomaji)
                    .font(.headline)
                    .lineLimit(2)
                
                if let description = anime.description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(3)
                }
                
                if !anime.genres.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(anime.genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.secondary.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview("Search View") {
    AnimeSearchView(router: Router(), isPresented: .constant(true))
}
