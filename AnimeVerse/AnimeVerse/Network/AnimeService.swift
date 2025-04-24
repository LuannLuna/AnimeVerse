//
//  AnimeService.swift
//  AnimeVerse
//
//  Created by Luann Luna on 23/04/25.
//

import AnilistAPI
import Foundation

protocol AnimeServiceProtocol {
    func fetchAnimes(page: Int, perPage: Int) async throws -> [Anime]
}

final class AnimeService: AnimeServiceProtocol {
    private let network: Network

    init(network: Network = Network()) {
        self.network = network
    }

    func fetchAnimes(page: Int, perPage: Int) async throws -> [Anime] {
        let query = AllAnimesQuery(page: .init(integerLiteral: page), perPage: .init(integerLiteral: perPage))

        let result = try await network.fetch(query: query)
        guard let media = result.data?.page?.media else { return [] }

        return media.compactMap { mediaItem in
            guard
                let id = mediaItem?.id,
                let romaji = mediaItem?.title?.romaji,
                let native = mediaItem?.title?.native,
                let coverURLString = mediaItem?.coverImage?.large,
                let coverURL = URL(string: coverURLString)
            else {
                return nil
            }

            let dateComponents = DateComponents(
                year: mediaItem?.startDate?.year,
                month: mediaItem?.startDate?.month,
                day: mediaItem?.startDate?.day
            )

            return Anime(
                id: id,
                titleRomaji: romaji,
                titleEnglish: mediaItem?.title?.english,
                titleNative: native,
                startDate: dateComponents,
                coverImageURL: coverURL
            )
        }
    }
}
