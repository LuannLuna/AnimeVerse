//
//  Network.swift
//  AnimeVerse
//
//  Created by Luann Luna on 14/04/25.
//

import Apollo
import Foundation

final class Network {
    private(set) var apollo: ApolloClient

    init(apollo: ApolloClient? = nil) {
        self.apollo = apollo ?? ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
    }
}
