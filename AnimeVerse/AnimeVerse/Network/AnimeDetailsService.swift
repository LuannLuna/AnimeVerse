import Foundation
import AnilistAPI

protocol AnimeDetailsServiceProtocol {
    func fetchAnimeDetails(id: Int) async throws -> AnimeDetails?
}

final class AnimeDetailsService: AnimeDetailsServiceProtocol {
    private let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchAnimeDetails(id: Int) async throws -> AnimeDetails? {
        let query = GetAnimeDetailsQuery(id: id)
        
        let result = try await network.fetch(query: query)
        guard let media = result.data?.media else { return nil }
        
        return AnimeDetails(from: media)
    }
}
