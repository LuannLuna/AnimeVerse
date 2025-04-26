import Foundation
import AnilistAPI

struct Manga: Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let description: String?
    let startDate: DateComponents
    let coverImageURL: URL?
}

extension Manga {
    init?(from data: AllMangasQuery.Data.Page.Medium) {
        guard let title = data.title,
              let romaji = title.romaji,
              let native = title.native,
              let startDate = data.startDate,
              let coverImage = data.coverImage,
              let coverImageURLString = coverImage.large,
              let coverImageURL = URL(string: coverImageURLString)
        else { return nil }
        self.id = data.id
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = native
        self.description = data.description
        self.startDate = DateComponents(
            year: startDate.year,
            month: startDate.month,
            day: startDate.day
        )
        self.coverImageURL = coverImageURL
    }
}
