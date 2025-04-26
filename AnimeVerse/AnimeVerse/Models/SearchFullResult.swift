import AnilistAPI
import Foundation

struct SearchFullResult: Identifiable, Codable, Hashable {
    let id: Int
    let type: MediaType
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String?
    let description: String?
    let startDate: DateComponents?
    let endDate: DateComponents?
    let episodes: Int?
    let duration: Int?
    let genres: [String]
    let averageScore: Int?
    let popularity: Int?
    let status: String?
    let coverImageURL: URL?
    let bannerImageURL: URL?
    let characters: [Character]

    enum MediaType: String, Codable {
        /// Japanese Anime
        case anime = "ANIME"
        /// Asian comic
        case manga = "MANGA"

        case unknown = "Unknown"

      }

    struct Character: Identifiable, Codable, Hashable {
        let id: Int
        let name: String
        let imageURL: URL?
        let role: String
        let voiceActors: [VoiceActor]
    }

    struct VoiceActor: Identifiable, Codable, Hashable {
        let id: Int
        let name: String
        let language: String
        let imageURL: URL?
    }
}

extension SearchFullResult {
    init?(from data: FindAnimeQuery.Data.Page.Medium) {
        guard let title = data.title, let romaji = title.romaji else { return nil }
        self.id = data.id
        self.type =  MediaType(rawValue: data.type?.rawValue ?? "") ?? .unknown
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = title.native
        self.description = data.description
        self.startDate = {
            guard let s = data.startDate else { return nil }
            return DateComponents(year: s.year, month: s.month, day: s.day)
        }()
        self.endDate = {
            guard let e = data.endDate else { return nil }
            return DateComponents(year: e.year, month: e.month, day: e.day)
        }()
        self.episodes = data.episodes
        self.duration = data.duration
        self.genres = data.genres?.compactMap { $0 } ?? []
        self.averageScore = data.averageScore
        self.popularity = data.popularity
        self.status = data.status?.rawValue
        self.coverImageURL = data.coverImage?.extraLarge?.asURL ?? data.coverImage?.large?.asURL ?? data.coverImage?.medium?.asURL
        self.bannerImageURL = data.bannerImage?.asURL
        self.characters = data.characters?.edges?.compactMap { edge in
            guard let edge = edge, let node = edge.node, let role = edge.role else { return nil }
            return Character(
                id: node.id,
                name: node.name?.full ?? node.name?.userPreferred ?? "",
                imageURL: node.image?.large?.asURL ?? node.image?.medium?.asURL,
                role: role.rawValue,
                voiceActors: edge.voiceActors?.compactMap { va in
                    guard let va = va else { return nil }
                    return VoiceActor(
                        id: va.id,
                        name: va.name?.full ?? va.name?.userPreferred ?? "",
                        language: va.languageV2 ?? "",
                        imageURL: va.image?.large?.asURL ?? va.image?.medium?.asURL
                    )
                } ?? []
            )
        } ?? []
    }
}
