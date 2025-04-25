import AnilistAPI
import Foundation

protocol AnimeSearchServiceProtocol {
    func searchAnimes(term: String, page: Int) async throws -> [AnimeDetails]
}

final class AnimeSearchService: AnimeSearchServiceProtocol {
    private let network: Network
    private let cache: CacheServiceProtocol
    
    init(
        network: Network = Network(),
        cache: CacheServiceProtocol = CacheService()
    ) {
        self.network = network
        self.cache = cache
    }
    
    func searchAnimes(term: String, page: Int) async throws -> [AnimeDetails] {
        let cacheKey = "search_\(term)_\(page)"
        
        // Try to get from cache first
        if let cached: [AnimeDetails] = try? cache.object(forKey: cacheKey) {
            return cached
        }
        
        // If not in cache, fetch from network
        let query = FindAnimeQuery(search: .init(stringLiteral: term), page: .some(page))
        let response = try await network.fetch(query: query)
        let results = response.data?.page?.media?.compactMap { $0?.asAnimeDetails } ?? []
        
        // Cache the results
        try? cache.cache(results, forKey: cacheKey)
        
        return results
    }
}

// MARK: - FindAnimeQuery.Data.Page.Medium Extension

private extension FindAnimeQuery.Data.Page.Medium {
    var asStartDate: DateComponents {
        .init(
            year: startDate?.year,
            month: startDate?.month,
            day: startDate?.day
        )
    }
    
    var asEndDate: DateComponents {
        .init(
            year: endDate?.year,
            month: endDate?.month,
            day: endDate?.day
        )
    }
    
    var asCharacterList: [AnimeDetails.Character] {
        characters?.edges?.compactMap { $0?.asCharacter } ?? []
    }
    
    var asCoverImageURL: URL? {
        coverImage?.extraLarge?.asURL ?? coverImage?.large?.asURL ?? coverImage?.medium?.asURL
    }
    
    var asBannerImageURL: URL? {
        bannerImage?.asURL
    }
    
    var asAnimeDetails: AnimeDetails {
        AnimeDetails(
            id: id,
            titleRomaji: title?.romaji ?? "",
            titleEnglish: title?.english,
            titleNative: title?.native ?? "",
            description: description,
            startDate: asStartDate,
            endDate: asEndDate,
            episodes: episodes,
            duration: duration,
            genres: genres?.compactMap { $0 } ?? [],
            averageScore: averageScore,
            popularity: popularity,
            status: status?.rawValue,
            coverImageURL: asCoverImageURL,
            bannerImageURL: asBannerImageURL,
            characters: asCharacterList
        )
    }
}

// MARK: - FindAnimeQuery.Data.Page.Medium.Character.Edge Extension

private extension FindAnimeQuery.Data.Page.Medium.Characters.Edge {
    var asCharacter: AnimeDetails.Character? {
        guard
            let node = node,
            let role = role
        else { return nil }
        
        return .init(
            id: node.id,
            name: node.name?.full ?? node.name?.userPreferred ?? "",
            imageURL: URL(string: node.image?.large ?? node.image?.medium ?? ""),
            role: role.rawValue,
            voiceActors: voiceActors?.compactMap { $0?.asVoiceActor } ?? []
        )
    }
}

// MARK: - FindAnimeQuery.Data.Page.Medium.Character.Edge.VoiceActor Extension

private extension FindAnimeQuery.Data.Page.Medium.Characters.Edge.VoiceActor {
    var asVoiceActor: AnimeDetails.VoiceActor {
        .init(
            id: id,
            name: name?.full ?? name?.userPreferred ?? "",
            language: languageV2 ?? "",
            imageURL: image?.large?.asURL ?? image?.medium?.asURL
        )
    }
}

#if DEBUG
final class AnimeSearchServiceMock: AnimeSearchServiceProtocol {
    var searchResult: [AnimeDetails] = []
    var searchError: Error?
    
    func searchAnimes(term: String, page: Int) async throws -> [AnimeDetails] {
        if let error = searchError {
            throw error
        }
        return searchResult
    }
}
#endif
