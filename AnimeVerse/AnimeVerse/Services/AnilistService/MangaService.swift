import Foundation
import AnilistAPI

protocol MangaServiceProtocol {
    func fetchMangas(page: Int, perPage: Int, sort: MediaSort) async throws -> [Media]
}

struct MangaService: MangaServiceProtocol {
    private let network: Network
    private let cache: CacheServiceProtocol

    init(
        network: Network = Network(),
        cache: CacheServiceProtocol = CacheService()
    ) {
        self.network = network
        self.cache = cache
    }

    func fetchMangas(page: Int, perPage: Int, sort: MediaSort = .scoreDesc) async throws -> [Media] {
        let cacheKey = "mangas_page\(page)_perPage\(perPage)_sort\(sort.rawValue)"

        // Try to get from cache first
        if let cached: [Media] = try? cache.object(forKey: cacheKey) {
            return cached
        }

        // If not in cache, fetch from network
        let query = AllMediasQuery(
            page: .init(integerLiteral: page),
            perPage: .init(integerLiteral: perPage),
            sort: .init(arrayLiteral: .init(rawValue: sort.rawValue)),
            type: .init(.manga)
        )

        let result = try await network.fetch(query: query)
        guard let media = result.data?.page?.media else { return [] }

        let mangas: [Media] = media.compactMap { mediaItem in
            guard let mediaItem else { return nil }
            return Media(from: mediaItem)
        }

        // Cache the results
        try? cache.cache(mangas, forKey: cacheKey)

        return mangas
    }
}
