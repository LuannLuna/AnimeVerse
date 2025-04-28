import SwiftUI
import Kingfisher

struct RecommendationsSection: View {
    let recommendations: [MediaDetails.Recommendations]
    let onSelect: (MediaDetails.Recommendations) -> Void

    var body: some View {
        if !recommendations.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Recommendations")
                    .font(.title2)
                    .bold()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(recommendations) { rec in
                            VStack(spacing: 8) {
                                if let url = rec.coverImageURL {
                                    KFImage(url)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 90, height: 130)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                Text(rec.titleEnglish ?? rec.titleRomaji)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            .onTapGesture {
                                onSelect(rec)
                            }
                            .frame(width: 100)
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview  {
    RecommendationsSection(
        recommendations: [
            .init(
                id: 1,
                type: .anime,
                titleRomaji: "Naruto",
                titleEnglish: "Naruto",
                titleNative: "ナルト",
                coverImageURL: nil
            ),
            .init(
                id: 2,
                type: .manga,
                titleRomaji: "One Piece",
                titleEnglish: "One Piece",
                titleNative: "ワンピース",
                coverImageURL: nil
            )
        ], onSelect: { _ in }
    )
    .padding()
}
#endif
