//
//  AnimeCardView.swift
//  AnimeVerse
//
//  Created by Luann Luna on 24/04/25.
//

import SwiftUI
import Kingfisher

struct AnimeCardView: View {
    let anime: Anime

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(anime.coverImageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 200)
                .clipped()
                .cornerRadius(12)

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
            startDate: .init(),
            coverImageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx191205-FIaAdNs3izsR.jpg")!
        )
    )
}
