import SwiftUI
import Kingfisher

struct WatchListItemCard: View {
    let item: FavoriteAnime

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GeometryReader { _ in
                KFImage(item.bannerImageURL)
                    .resizable()
                    .scaledToFill()
            }
            .frame(height: 100)
            .cornerRadius(8)
            .clipped()

            Text(item.titleEnglish ?? item.titleNative ?? "")
                .font(.system(size: 14, weight: .semibold))
        }
        .frame(height: 160)
        .padding(.bottom)
    }
}

#Preview {
    WatchListItemCard(item: .init(from: .mock))
}
