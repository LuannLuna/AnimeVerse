import SwiftUI
import SwiftData
import Kingfisher

struct FavoritesView: View {
    @Environment(Router.self) private var router: Router
    @Query(sort: \FavoriteAnime.addedDate, order: .reverse) private var favorites: [FavoriteAnime]
    @Environment(\.modelContext) private var modelContext

    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)

    var body: some View {
        NavigationView {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text("Your favorite animes will appear here")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favorites, id: \.id) { anime in
                                FavoriteAnimeCard(anime: anime)
                                    .onTapGesture {
                                        switch anime.mediaType {
                                        case .anime:
                                            router.navigate(to: .details(animeId: anime.id), using: .push)
                                        case .manga:
                                            router.navigate(to: .mangaDetail(mangaId: anime.id), using: .push)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
