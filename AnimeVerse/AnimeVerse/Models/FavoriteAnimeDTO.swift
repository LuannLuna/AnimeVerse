import Foundation

struct FavoriteAnimeDTO: Codable, Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String?
    let description: String?
    let coverImageURL: String?
    let bannerImageURL: String?
    let addedDate: Date?
    let startDate: Date?
    let mediaType: String // "anime" or "manga"
}

extension FavoriteAnimeDTO {
    init(from model: FavoriteAnime) {
        id = model.id
        titleRomaji = model.titleRomaji
        titleEnglish = model.titleEnglish
        titleNative = model.titleNative
        description = model.descriptionText
        coverImageURL = model.coverImageURL?.absoluteString
        bannerImageURL = model.bannerImageURL?.absoluteString
        addedDate = model.addedDate
        mediaType = model.mediaType.rawValue
        startDate = model.startDate
    }

    func toFavoriteAnime() -> FavoriteAnime {
        return FavoriteAnime(
            id: id,
            titleRomaji: titleRomaji,
            titleEnglish: titleEnglish,
            titleNative: titleNative,
            description: description,
            coverImageURL: coverImageURL?.asURL,
            bannerImageURL: bannerImageURL?.asURL,
            mediaType: MediaKind(rawValue: mediaType) ?? .anime,
            startDate: startDate
        )
    }
}
