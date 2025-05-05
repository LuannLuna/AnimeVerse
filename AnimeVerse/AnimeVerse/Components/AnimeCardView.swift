import SwiftUI
import Kingfisher

struct AnimeCardView: View {
    let anime: Anime

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(anime.coverImageURL)
                .placeholder {
                    ProgressView()
                }
                .retry(maxCount: 3, interval: .seconds(2))
                .resizable()
                .aspectRatio(2/3, contentMode: .fit)
                .cornerRadius(12)
                .clipped()

            Text(anime.titleRomaji)
                .font(.headline)
                .lineLimit(2)
                .padding(.top, 5)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AnimeCardView(
        anime: .init(
            id: 191205,
            titleRomaji: "Okiraku Ryoushu no Tanoshii Ryouchi Bouei",
            titleEnglish: nil,
            titleNative: "お気楽領主の楽しい領地防衛",
            description: "A story about a young man who dreams of becoming a great general.",
            startDate: .init(),
            coverImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx191205-FIaAdNs3izsR.jpg")!
        )
    )
}
