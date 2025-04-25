import AnilistAPI
import Foundation

struct AnimeSearchResult: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String?
    let description: String?
    let genres: [String]
    let coverImageURL: URL?
}

extension AnimeSearchResult {
    init?(from data: FindAnimeQuery.Data.Page.Medium) {
        guard
              let title = data.title,
              let romaji = title.romaji else {
            return nil
        }
        self.id = data.id
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = title.native
        self.description = data.description
        self.genres = data.genres?.compactMap(\.?.description) ?? []
        self.coverImageURL = (data.coverImage?.extraLarge ?? data.coverImage?.large)?.asURL
    }
}
