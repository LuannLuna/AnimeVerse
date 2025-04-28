import AnilistAPI
import Foundation

protocol SearchServiceProtocol {
    func searchMedia(term: String, page: Int, kind: MediaKind) async throws -> [MediaDetails]
}

final class SearchService: SearchServiceProtocol {
    private let network: Network
    private let cache: CacheServiceProtocol

    init(
        network: Network = Network(),
        cache: CacheServiceProtocol = CacheService()
    ) {
        self.network = network
        self.cache = cache
    }

    func searchMedia(term: String, page: Int, kind: MediaKind) async throws -> [MediaDetails] {
        let cacheKey = "search_\(term)_\(page)"

        // Try to get from cache first
        if let cached: [MediaDetails] = try? cache.object(forKey: cacheKey) {
            return cached
        }

        // If not in cache, fetch from network
        let query = FindMediaQuery(search: .init(stringLiteral: term), page: .some(page), type: .init(kind.anilistType))
        let response = try await network.fetch(query: query)
        let results: [MediaDetails] = response.data?.page?.media?.compactMap { media in
            guard let media else { return nil }
            return MediaDetails(from: media)
        } ?? []

        // Cache the results
        try? cache.cache(results, forKey: cacheKey)

        return results
    }
}
