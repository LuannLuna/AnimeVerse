import Foundation
import SwiftData

@Model
final class FavoriteAnime {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String?
    let coverImageURL: URL?
    let addedDate: Date
    
    init(id: Int, titleRomaji: String, titleEnglish: String?, titleNative: String?, coverImageURL: URL?) {
        self.id = id
        self.titleRomaji = titleRomaji
        self.titleEnglish = titleEnglish
        self.titleNative = titleNative
        self.coverImageURL = coverImageURL
        self.addedDate = Date()
    }
    
    convenience init(from details: AnimeDetails) {
        self.init(
            id: details.id,
            titleRomaji: details.titleRomaji,
            titleEnglish: details.titleEnglish,
            titleNative: details.titleNative,
            coverImageURL: details.coverImageURL
        )
    }
}
