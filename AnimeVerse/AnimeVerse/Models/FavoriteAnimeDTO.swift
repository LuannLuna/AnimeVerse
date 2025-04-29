import Foundation

struct FavoriteAnimeDTO: Codable, Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String?
    let coverImageURL: String?
    let bannerImageURL: String?
    let addedDate: Date
    let mediaType: String // "anime" or "manga"

    init(from model: FavoriteAnime) {
        id = model.id
        titleRomaji = model.titleRomaji
        titleEnglish = model.titleEnglish
        titleNative = model.titleNative
        coverImageURL = model.coverImageURL?.absoluteString
        bannerImageURL = model.bannerImageURL?.absoluteString
        addedDate = model.addedDate
        mediaType = model.mediaType.rawValue
    }

    func toFavoriteAnime() -> FavoriteAnime {
        return FavoriteAnime(
            id: id,
            titleRomaji: titleRomaji,
            titleEnglish: titleEnglish,
            titleNative: titleNative,
            coverImageURL: coverImageURL.flatMap { URL(string: $0) },
            bannerImageURL: bannerImageURL.flatMap { URL(string: $0) },
            mediaType: FavoriteAnime.MediaKind(rawValue: mediaType) ?? .anime
        )
    }
}
