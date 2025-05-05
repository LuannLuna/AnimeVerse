import Foundation
import AnilistAPI

struct Anime: Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let description: String?
    let startDate: Date?
    let coverImageURL: URL?
}

extension Anime {
    init(from favorite: FavoriteAnime) {
        self.id = favorite.id
        self.titleRomaji = favorite.titleRomaji
        self.titleEnglish = favorite.titleEnglish
        self.titleNative = favorite.titleNative ?? favorite.titleRomaji
        self.startDate = favorite.startDate
        self.coverImageURL = favorite.coverImageURL
        self.description = favorite.descriptionText
    }

    init?(from data: AllAnimesQuery.Data.Page.Medium) {
        guard let title = data.title,
              let romaji = title.romaji,
              let native = title.native,
              let startDate = data.startDate,
              let coverImage = data.coverImage,
              let coverImageURLString = coverImage.large,
              let coverImageURL = coverImageURLString.asURL else {
            return nil
        }

        self.id = data.id
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = native
        self.description = data.description
        self.startDate = DateComponents(
            year: startDate.year,
            month: startDate.month,
            day: startDate.day
        ).date
        self.coverImageURL = coverImageURL
    }

    init(from details: MediaDetails) {
        self.id = details.id
        self.titleRomaji = details.titleRomaji
        self.titleEnglish = details.titleEnglish
        self.titleNative = details.titleNative
        self.description = details.description
        self.startDate = details.startDate
        self.coverImageURL = details.coverImageURL
    }
}
