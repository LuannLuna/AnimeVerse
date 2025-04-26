import Foundation
import AnilistAPI

struct Anime: Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let startDate: DateComponents?
    let coverImageURL: URL?
}

extension Anime {
    init?(from data: AllAnimesQuery.Data.Page.Medium) {
        guard let title = data.title,
              let romaji = title.romaji,
              let native = title.native,
              let startDate = data.startDate,
              let coverImage = data.coverImage,
              let coverImageURLString = coverImage.large,
              let coverImageURL = URL(string: coverImageURLString) else {
            return nil
        }
        
        self.id = data.id
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = native
        self.startDate = DateComponents(
            year: startDate.year,
            month: startDate.month,
            day: startDate.day
        )
        self.coverImageURL = coverImageURL
    }
    
    init(from details: MediaDetails) {
        self.id = details.id
        self.titleRomaji = details.titleRomaji
        self.titleEnglish = details.titleEnglish
        self.titleNative = details.titleNative
        self.startDate = details.startDate
        self.coverImageURL = details.coverImageURL
    }
}
