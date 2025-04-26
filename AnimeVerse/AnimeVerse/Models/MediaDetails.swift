import Foundation
import AnilistAPI

struct MediaDetails: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let type: MediaType
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
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
    let characters: [Self.Character]

    struct Character: Identifiable, Equatable, Codable, Hashable {
        let id: Int
        let name: String
        let imageURL: URL?
        let role: String
        let voiceActors: [VoiceActor]
    }
    
    struct VoiceActor: Identifiable, Equatable, Codable, Hashable {
        let id: Int
        let name: String
        let language: String
        let imageURL: URL?
    }

    enum MediaType: String, Codable {
        case anime = "ANIME"
        case manga = "MANGA"
        case unknown = "Unknown"
    }
}

extension MediaDetails {
    init?(from data: GetMediaDetailsQuery.Data.Media) {
        guard let title = data.title,
              let romaji = title.romaji,
              let native = title.native,
              let startDate = data.startDate,
              let coverImage = data.coverImage,
              let coverImageURLString = coverImage.extraLarge ?? coverImage.large ?? coverImage.medium,
              let coverImageURL = URL(string: coverImageURLString)
        else { return nil }
        self.id = data.id
        self.type = .init(rawValue: (data.type?.rawValue ?? "")) ?? .unknown
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = native
        self.description = data.description
        self.startDate = DateComponents(
            year: startDate.year,
            month: startDate.month,
            day: startDate.day
        )
        if let endDate = data.endDate {
            self.endDate = DateComponents(
                year: endDate.year,
                month: endDate.month,
                day: endDate.day
            )
        } else {
            self.endDate = nil
        }
        self.episodes = data.episodes
        self.duration = data.duration
        self.genres = data.genres?.compactMap(\.?.description) ?? []
        self.averageScore = data.averageScore
        self.popularity = data.popularity
        self.status = data.status?.rawValue
        self.coverImageURL = coverImageURL
        self.bannerImageURL = data.bannerImage.flatMap { URL(string: $0) }
        var characters: [Character] = []
        data.characters?.edges?.forEach { edge in
            if let node = edge?.node {
                let character = Character(
                    id: node.id,
                    name: node.name?.full ?? node.name?.userPreferred ?? "",
                    imageURL: node.image?.large.flatMap { URL(string: $0) } ?? node.image?.medium.flatMap { URL(string: $0) },
                    role: edge?.role?.rawValue ?? "",
                    voiceActors: (edge?.voiceActors ?? []).compactMap { va in
                        guard let va else { return nil }
                        return VoiceActor(
                            id: va.id,
                            name: va.name?.full ?? va.name?.userPreferred ?? "",
                            language: va.languageV2 ?? "",
                            imageURL: va.image?.large.flatMap { URL(string: $0) } ?? va.image?.medium.flatMap { URL(string: $0) }
                        )
                    }
                )
                characters.append(character)
            }
        }
        self.characters = characters
    }

    init?(from data: FindMediaQuery.Data.Page.Medium) {
        guard let title = data.title, let romaji = title.romaji else { return nil }
        self.id = data.id
        self.type =  MediaType(rawValue: data.type?.rawValue ?? "") ?? .unknown
        self.titleRomaji = romaji
        self.titleEnglish = title.english
        self.titleNative = title.native ?? ""
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
                    guard let va else { return nil }
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
