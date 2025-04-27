//
//  AnimeService.swift
//  AnimeVerse
//
//  Created by Luann Luna on 23/04/25.
//

import AnilistAPI
import Foundation

protocol AnimeServiceProtocol {
    func fetchAnimes(page: Int, perPage: Int, sort: MediaSort) async throws -> [Anime]
}

final class AnimeService: AnimeServiceProtocol {
    private let network: Network

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchAnimes(page: Int, perPage: Int, sort: MediaSort = .scoreDesc) async throws -> [Anime] {
        let query = AllAnimesQuery(
            page: .init(integerLiteral: page),
            perPage: .init(integerLiteral: perPage),
            sort: .init(arrayLiteral: .init(rawValue: sort.rawValue))
        )

        let result = try await network.fetch(query: query)
        guard let media = result.data?.page?.media else { return [] }

        return media.compactMap { mediaItem in
            guard let mediaItem else { return nil }
            return Anime(from: mediaItem)
        }
    }
}
