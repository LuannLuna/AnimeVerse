import SwiftUI
import Kingfisher

struct FavoriteAnimeCard: View {
    let anime: FavoriteAnime

    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = anime.bannerImageURL ?? anime.coverImageURL {
                GeometryReader { _ in
                    KFImage(imageURL)
                        .placeholder {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .fade(duration: 0.25)
                        .cancelOnDisappear(true)
                        .resizable()
                        .scaledToFill()
                }
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            }

            VStack(alignment: .leading, spacing: 4) {
                Text(anime.titleRomaji)
                    .font(.title3)
                    .bold()
                    .lineLimit(2)

                if let englishTitle = anime.titleEnglish {
                    Text(englishTitle)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview("Favorite Anime Card") {
    ScrollView {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 1), spacing: 16) {
            // With all information
            FavoriteAnimeCard(
                anime: .init(
                    id: 1,
                    titleRomaji: "Demon Slayer",
                    titleEnglish: "Demon Slayer: Kimetsu no Yaiba",
                    titleNative: "鬼滅の刃",
                    description: "Description",
                    coverImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx188889-9mNMLHCXJmUw.png"),
                    bannerImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/178680-9HupCDo647QU.jpg"),
                    mediaType: .anime,
                    startDate: Date()
                )
            )

            // Without English title
            FavoriteAnimeCard(
                anime: .init(
                    id: 2,
                    titleRomaji: "進撃の巨人",
                    titleEnglish: nil,
                    titleNative: "進撃の巨人",
                    description: "Description",
                    coverImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx188889-9mNMLHCXJmUw.png"),
                    bannerImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/178680-9HupCDo647QU.jpg"),
                    mediaType: .anime,
                    startDate: Date()
                )
            )

            // With long titles
            FavoriteAnimeCard(
                anime: .init(
                    id: 3,
                    titleRomaji: "A Very Long Anime Title That Should Be Truncated Because It's Too Long",
                    titleEnglish: "An Even Longer English Title That Should Also Be Truncated",
                    titleNative: "超長いタイトル",
                    description: "Description",
                    coverImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx188889-9mNMLHCXJmUw.png"),
                    bannerImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/banner/178680-9HupCDo647QU.jpg"),
                    mediaType: .anime,
                    startDate: Date()
                )
            )
        }
        .padding()
    }
}
