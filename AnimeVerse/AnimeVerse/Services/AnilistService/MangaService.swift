import Foundation
import AnilistAPI

protocol MangaServiceProtocol {
    func fetchMangas(page: Int, perPage: Int, sort: MediaSort) async throws -> [Media]
}

struct MangaService: MangaServiceProtocol {
    private let network: Network

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchMangas(page: Int, perPage: Int, sort: MediaSort = .scoreDesc) async throws -> [Media] {
        let query = AllMediasQuery(
            page: .init(integerLiteral: page),
            perPage: .init(integerLiteral: perPage),
            sort: .init(arrayLiteral: .init(rawValue: sort.rawValue)),
            type: .init(.manga)
        )

        let result = try await network.fetch(query: query)
        guard let media = result.data?.page?.media else { return [] }
        return media.compactMap { mediaItem in
            guard let mediaItem else { return nil }
            return Media(from: mediaItem)
        }
    }
}
