import Foundation
import SwiftData

@Model
final class FavoriteAnime {
    enum MediaKind: String, Codable {
        case anime
        case manga
    }
    private(set) var id: Int
    private(set) var titleRomaji: String
    private(set) var titleEnglish: String?
    private(set) var titleNative: String?
    private(set) var coverImageURL: URL?
    private(set) var bannerImageURL: URL?
    private(set) var addedDate: Date
    private(set) var startDate: Date?
    private(set) var mediaType: MediaKind

    init(
        id: Int,
        titleRomaji: String,
        titleEnglish: String?,
        titleNative: String?,
        coverImageURL: URL?,
        bannerImageURL: URL?,
        mediaType: MediaKind,
        startDate: Date? = nil
    ) {
        self.id = id
        self.titleRomaji = titleRomaji
        self.titleEnglish = titleEnglish
        self.titleNative = titleNative
        self.coverImageURL = coverImageURL
        self.bannerImageURL = bannerImageURL
        self.addedDate = Date()
        self.mediaType = mediaType
        self.startDate = startDate
    }

    convenience init(from details: MediaDetails) {
        self.init(
            id: details.id,
            titleRomaji: details.titleRomaji,
            titleEnglish: details.titleEnglish,
            titleNative: details.titleNative,
            coverImageURL: details.coverImageURL,
            bannerImageURL: details.bannerImageURL,
            mediaType: details.type == .manga ? .manga : .anime,
            startDate: details.startDate
        )
    }
}
