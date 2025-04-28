import SwiftUI
import Kingfisher

import Observation

import SwiftData

struct MangaDetailView: View {
    @Environment(Router.self) private var router: Router
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteAnime]
    @State private var viewModel: MangaDetailViewModel

    init(mangaId: Int) {
        _viewModel = State(initialValue: MangaDetailViewModel(mangaId: mangaId))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading manga...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text("Error")
                        .font(.title)
                    Text(error)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let manga = viewModel.mediaDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Banner or Cover
                        if let bannerURL = manga.bannerImageURL ?? manga.coverImageURL {
                            GeometryReader { _ in
                                KFImage(bannerURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .frame(height: 180)
                            .clipped()
                            .ignoresSafeArea()
                        }
                        VStack(alignment: .leading, spacing: 24) {
                            // Title
                            Text(manga.titleEnglish ?? manga.titleRomaji)
                                .font(.title)
                                .bold()
                            // Genres
                            if !manga.genres.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(manga.genres, id: \.self) { genre in
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
                            // Description
                            if let desc = manga.description {
                                HTMLText(desc)
                                    .foregroundStyle(.secondary)
                            }
                            // Info
                            HStack(spacing: 16) {
                                if let score = manga.averageScore {
                                    Label("\(score)", systemImage: "star.fill")
                                }
                                if let popularity = manga.popularity {
                                    Label("\(popularity)", systemImage: "person.3.fill")
                                }
                                if let status = manga.status {
                                    Label(status.capitalized, systemImage: "checkmark.seal")
                                }
                            }
                            // Characters
                            if !manga.characters.isEmpty {
                                Text("Characters")
                                    .font(.headline)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(manga.characters) { character in
                                            VStack(spacing: 8) {
                                                if let url = character.imageURL {
                                                    KFImage(url)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 80, height: 120)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                }
                                                Text(character.name)
                                                    .font(.caption)
                                                    .lineLimit(2)
                                                Text(character.role.capitalized)
                                                    .font(.caption2)
                                                    .foregroundStyle(.secondary)
                                                if !character.voiceActors.isEmpty {
                                                    Text("VA: " + character.voiceActors.map { $0.name }.joined(separator: ", "))
                                                        .font(.caption2)
                                                        .foregroundStyle(.secondary)
                                                        .lineLimit(2)
                                                }
                                            }
                                            .frame(width: 90)
                                        }
                                    }
                                }
                            }

                            if !manga.recommendations.isEmpty {
                                RecommendationsSection(recommendations: manga.recommendations, onSelect: { rec in
                                    router.navigate(to: .mangaDetail(mangaId: rec.id), using: .push)
                                })
                            }
                        }
                        .padding()

                    }
                }
                .navigationTitle(viewModel.mediaDetails?.titleRomaji ?? "Manga Details")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("No manga details available.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            await viewModel.loadMangaDetails()
        }
        .navigationTitle(viewModel.mediaDetails?.titleEnglish ?? viewModel.mediaDetails?.titleRomaji ?? "Manga Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let details = viewModel.mediaDetails {
                let isFavorite = favorites.contains { $0.id == details.id }
                Button {
                    toggleFavorite(details: details)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? .red : .primary)
                }
            }
        }
    }

    private func toggleFavorite(details: MediaDetails) {
        if let existingFavorite = favorites.first(where: { $0.id == details.id }) {
            modelContext.delete(existingFavorite)
        } else {
            let favorite = FavoriteAnime(from: details)
            modelContext.insert(favorite)
        }
    }
}

#Preview {
    MangaDetailView(mangaId: 1)
        .environment(Router())
}
