import AnilistAPI
import Foundation

protocol AnimeSearchServiceProtocol {
    func searchAnimes(term: String, page: Int) async throws -> [SearchFullResult]
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
    
    func searchAnimes(term: String, page: Int) async throws -> [SearchFullResult] {
        let cacheKey = "search_\(term)_\(page)"
        
        // Try to get from cache first
        if let cached: [SearchFullResult] = try? cache.object(forKey: cacheKey) {
            return cached
        }
        
        // If not in cache, fetch from network
        let query = FindAnimeQuery(search: .init(stringLiteral: term), page: .some(page))
        let response = try await network.fetch(query: query)
        let results: [SearchFullResult] = response.data?.page?.media?.compactMap { media in
            if let media {
                SearchFullResult(from: media)
            } else {
                nil
            }
        } ?? []
        
        // Cache the results
        try? cache.cache(results, forKey: cacheKey)
        
        return results
    }
}
