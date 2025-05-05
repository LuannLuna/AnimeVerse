//
//  Network.swift
//  AnimeVerse
//
//  Created by Luann Luna on 14/04/25.
//

import AnilistAPI
import Apollo
import Foundation

struct Network {
    private let apollo: ApolloClient

    init(apollo: ApolloClient? = nil) {
        self.apollo = apollo ?? ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
    }

    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Query.Data> {
        try await apollo.fetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue)
    }
}
