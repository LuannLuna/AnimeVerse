import Foundation
import SwiftData

@Model
final class FavoriteAnime {
    private(set) var id: Int
    private(set) var titleRomaji: String
    private(set) var titleEnglish: String?
    private(set) var titleNative: String?
    private(set) var coverImageURL: URL?
    private(set) var bannerImageURL: URL?
    private(set) var addedDate: Date

    init(id: Int, titleRomaji: String, titleEnglish: String?, titleNative: String?, coverImageURL: URL?, bannerImageURL: URL?) {
        self.id = id
        self.titleRomaji = titleRomaji
        self.titleEnglish = titleEnglish
        self.titleNative = titleNative
        self.coverImageURL = coverImageURL
        self.addedDate = Date()
    }
    
    convenience init(from details: MediaDetails) {
        self.init(
            id: details.id,
            titleRomaji: details.titleRomaji,
            titleEnglish: details.titleEnglish,
            titleNative: details.titleNative,
            coverImageURL: details.coverImageURL,
            bannerImageURL: details.bannerImageURL
        )
    }
}
