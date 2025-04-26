import SwiftUI
import Kingfisher

struct SearchView: View {
    @Bindable var router: Router
    @State private var viewModel = SearchViewModel()
    @State private var searchTask: Task<Void, Never>?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.medias.isEmpty && !viewModel.isLoading {
                    ContentUnavailableView.search
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.medias, id: \.id) { media in
                                AnimeSearchCard(anime: media)
                                    .onTapGesture {
                                        isPresented = false
                                        switch media.type {
                                            case .manga:
                                                router.navigate(to: .mangaDetail(manga: media), using: .push)
                                            default:
                                                router.navigate(to: .details(animeId: media.id), using: .push)
                                        }
                                    }
                                    .task {
                                        if media.id == viewModel.medias.last?.id {
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
    let anime: MediaDetails
    
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
                HStack(spacing: 8) {
                    Text(anime.type == .anime ? "Anime" : (anime.type == .manga ? "Manga" : "Other"))
                        .font(.caption2)
                        .bold()
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(anime.type == .anime ? Color.blue.opacity(0.15) : Color.green.opacity(0.15))
                        .foregroundColor(anime.type == .anime ? .blue : .green)
                        .clipShape(Capsule())
                    Spacer()
                }
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
    SearchView(router: Router(), isPresented: .constant(true))
}
