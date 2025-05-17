import Foundation
import AnilistAPI
import Apollo

enum MediaKind: String, Codable {
    case anime
    case manga

    var anilistType: MediaType {
        switch self {
        case .anime: return .anime
        case .manga: return .manga
        }
    }
}

protocol MediaDetailsServiceProtocol {
    func fetchMediaDetails(id: Int, kind: MediaKind) async throws -> MediaDetails?
}

struct MediaDetailsService: MediaDetailsServiceProtocol {
    private let network: Network
    private let cache: CacheServiceProtocol

    init(
        network: Network = Network(),
        cache: CacheServiceProtocol = CacheService()
    ) {
        self.network = network
        self.cache = cache
    }

    func fetchMediaDetails(id: Int, kind: MediaKind) async throws -> MediaDetails? {
        let cacheKey = "media_details_\(id)_\(kind.rawValue)"

        // Try to get from cache first
        if let cached: MediaDetails = try? cache.object(forKey: cacheKey) {
            return cached
        }

        // If not in cache, fetch from network
        let query = GetMediaDetailsQuery(id: id, type: .init(kind.anilistType))
        let result = try await network.fetch(query: query)
        guard let media = result.data?.media else { return nil }

        let details = MediaDetails(from: media)

        // Cache the results
        try? cache.cache(details, forKey: cacheKey)

        return details
    }
}
