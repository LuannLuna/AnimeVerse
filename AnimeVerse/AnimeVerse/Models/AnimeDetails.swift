import Foundation
import AnilistAPI

struct AnimeDetails: Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let description: String?
    let startDate: DateComponents
    let endDate: DateComponents?
    let episodes: Int?
    let duration: Int?
    let genres: [String]
    let averageScore: Int?
    let popularity: Int?
    let status: String?
    let coverImageURL: URL
    let bannerImageURL: URL?
    let characters: [Character]
    
    struct Character: Identifiable, Equatable {
        let id: Int
        let name: String
        let imageURL: URL?
        let role: String
        let voiceActors: [VoiceActor]
    }
    
    struct VoiceActor: Identifiable, Equatable {
        let id: Int
        let name: String
        let language: String
        let imageURL: URL?
    }
}

extension AnimeDetails {
    init?(from data: GetAnimeDetailsQuery.Data.Media) {
        guard let title = data.title,
              let romaji = title.romaji,
              let native = title.native,
              let startDate = data.startDate,
              let coverImage = data.coverImage,
              let coverImageURLString = coverImage.extraLarge ?? coverImage.large ?? coverImage.medium,
              let coverImageURL = URL(string: coverImageURLString) else {
            return nil
        }

        self.id = data.id
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
        self.genres = data.genres?.compactMap { $0 } ?? []
        self.averageScore = data.averageScore
        self.popularity = data.popularity
        self.status = data.status?.rawValue
        self.coverImageURL = coverImageURL
        self.bannerImageURL = data.bannerImage?.asURL ?? coverImageURL

        self.characters = data.characters?.edges?.compactMap { edge in
            guard let node = edge?.node,
                  let name = node.name?.userPreferred ?? node.name?.full else {
                return nil
            }

            let imageURL = node.image?.large ?? node.image?.medium

            let voiceActors = (edge?.voiceActors ?? []).compactMap { actor -> VoiceActor? in
                guard let actor = actor,
                      let name = actor.name?.userPreferred ?? actor.name?.full,
                      let language = actor.languageV2 else {
                    return nil
                }

                return VoiceActor(
                    id: actor.id,
                    name: name,
                    language: language,
                    imageURL: actor.image?.large?.asURL ?? actor.image?.medium?.asURL
                )
            }

            return Character(
                id: node.id,
                name: name,
                imageURL: imageURL?.asURL,
                role: edge?.role?.rawValue ?? "Unknown",
                voiceActors: voiceActors
            )
        } ?? []
    }
}
