import Foundation
import AnilistAPI

struct Media: Identifiable, Equatable, Codable {
    enum MediaType: String, Codable {
        case anime
        case manga
    }

    let id: Int
    let mediaType: MediaType
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let description: String?
    let startDate: DateComponents?
    let coverImageURL: URL?
    // Optional: Add bannerImageURL if needed for parity with FavoriteAnime
    let bannerImageURL: URL?
}

// MARK: - Initializers
extension Media {
    // From FavoriteAnime (if needed)
    init(from favorite: FavoriteAnime) {
        self.id = favorite.id
        self.mediaType = favorite.mediaType == .manga ? .manga : .anime
        self.titleRomaji = favorite.titleRomaji
        self.titleEnglish = favorite.titleEnglish
        self.titleNative = favorite.titleNative ?? favorite.titleRomaji
        self.description = favorite.descriptionText
        self.startDate = favorite.startDate?.toDateComponents()
        self.coverImageURL = favorite.coverImageURL
        self.bannerImageURL = favorite.bannerImageURL
    }

    // From Anime GraphQL
    init?(from data: AllMediasQuery.Data.Page.Medium) {
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
        self.mediaType = .anime
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
        self.bannerImageURL = nil
    }

    // From MediaDetails
    init(from details: MediaDetails) {
        self.id = details.id
        self.mediaType = details.type == .manga ? .manga : .anime
        self.titleRomaji = details.titleRomaji
        self.titleEnglish = details.titleEnglish
        self.titleNative = details.titleNative
        self.description = details.description
        self.startDate = details.startDate
        self.coverImageURL = details.coverImageURL
        self.bannerImageURL = details.bannerImageURL
    }
}
