//
//  HomeViewModel.swift
//  AnimeVerse
//
//  Created by Luann Luna on 23/04/25.
//

import Foundation
import Combine

@Observable
class HomeViewModel {
    var animes: [Anime] = []
    var filteredAnimes: [Anime] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var searchText: String = "" {
        didSet {
//            filterAnimes()
        }
    }
    private var currentPpage: Int = .zero
    private var perPage: Int = 100

    private let service = AnimeService()

    func loadAnimes() async {
        defer { isLoading = false }
        isLoading = true
        errorMessage = nil
        do {
            async let animes = service.fetchAnimes(page: currentPpage, perPage: perPage)
            self.animes = try await animes
            perPage = try await animes.count
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
