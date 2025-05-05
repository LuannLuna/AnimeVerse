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

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchMediaDetails(id: Int, kind: MediaKind) async throws -> MediaDetails? {
        let query = GetMediaDetailsQuery(id: id, type: .init(kind.anilistType))
        let result = try await network.fetch(query: query)
        guard let media = result.data?.media else { return nil }
        return MediaDetails(from: media)
    }
}
