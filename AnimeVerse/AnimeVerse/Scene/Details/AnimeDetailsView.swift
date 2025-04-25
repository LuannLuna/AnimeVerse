import Kingfisher
import SwiftData
import SwiftUI


struct AnimeDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteAnime]
    @State private var viewModel: AnimeDetailsViewModel
    
    init(animeId: Int) {
        _viewModel = State(initialValue: AnimeDetailsViewModel(animeId: animeId))
    }
    
    var body: some View {
        ScrollView {
            content
                .task {
                    await viewModel.loadAnimeDetails()
                }
        }
        .navigationTitle(viewModel.animeDetails?.titleEnglish ?? viewModel.animeDetails?.titleRomaji ?? "Anime Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let details = viewModel.animeDetails {
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
    
    private func toggleFavorite(details: AnimeDetails) {
        if let existingFavorite = favorites.first(where: { $0.id == details.id }) {
            modelContext.delete(existingFavorite)
        } else {
            let favorite = FavoriteAnime(from: details)
            modelContext.insert(favorite)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if let details = viewModel.animeDetails {
            VStack(alignment: .leading, spacing: 16) {
                // Banner Image
                if let bannerURL = details.bannerImageURL {
                    GeometryReader { _ in
                        KFImage(bannerURL)
                            .placeholder {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .fade(duration: 0.25)
                            .cancelOnDisappear(true)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .frame(height: 200)
                    .clipped()
                }

                // Main Content
                VStack(alignment: .leading, spacing: 16) {
                    // Title Section
                    VStack(alignment: .leading, spacing: 4) {
                        Text(details.titleRomaji)
                            .font(.title)
                            .bold()

                        if let englishTitle = details.titleEnglish {
                            Text(englishTitle)
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }

                        Text(details.titleNative)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }

                    // Info Section
                    VStack(alignment: .leading, spacing: 8) {
                        if let description = details.description {
                            HTMLText(description)
                        }

                        // Metadata
                        HStack {
                            if let episodes = details.episodes {
                                Label("\(episodes) episodes", systemImage: "play.tv")
                            }

                            if let duration = details.duration {
                                Label("\(duration) min", systemImage: "clock")
                            }
                        }
                        .foregroundColor(.secondary)

                        // Genres
                        FlowLayout(spacing: 8) {
                            ForEach(details.genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(20)
                            }
                        }
                    }

                    // Characters Section
                    if !details.characters.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Characters")
                                .font(.title2)
                                .bold()

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(details.characters) { character in
                                        CharacterCard(character: character)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding()
            }
        } else if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            VStack {
                Text("Error")
                    .font(.title)
                Text(error)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Flow Layout
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, proposal: proposal).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, proposal: proposal).offsets
        
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: bounds.origin.x + offset.x, y: bounds.origin.y + offset.y), proposal: .unspecified)
        }
    }
    
    private func layout(sizes: [CGSize], proposal: ProposedViewSize) -> (offsets: [CGPoint], size: CGSize) {
        let width = proposal.width ?? .infinity
        var offsets: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxY: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for size in sizes {
            if currentX + size.width > width && currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            
            offsets.append(CGPoint(x: currentX, y: currentY))
            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
            maxY = max(maxY, currentY + size.height)
        }
        
        return (offsets, CGSize(width: width, height: maxY))
    }
}

#Preview {
    AnimeDetailsView(animeId: 178680)
}
