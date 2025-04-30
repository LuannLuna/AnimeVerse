import SwiftUI
import Kingfisher

struct PlanListItemCard: View {
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
                .lineLimit(1)

            Text(item.addedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(height: 160)
        .padding(.bottom)
    }
}

#Preview {
    PlanListItemCard(
        item: FavoriteAnime(from: .mock)
    )
}
