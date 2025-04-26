import Foundation

enum MangaSort: String, CaseIterable, Identifiable {
    case trendingDesc = "TRENDING_DESC"
    case popularityDesc = "POPULARITY_DESC"
    case scoreDesc = "SCORE_DESC"

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .trendingDesc: return "Trending Now"
        case .popularityDesc: return "Most Popular"
        case .scoreDesc: return "Top Rated"
        }
    }
}

@Observable
final class MangaViewModel {
    private let service: MangaServiceProtocol
    private(set) var mangas: [Manga] = []
    private(set) var isLoading = false
    private(set) var error: Error?
    private var currentPage = 1
    private let perPage = 20
    private var canLoadMore = true
    private var sort: MangaSort = .scoreDesc
    
    init(service: MangaServiceProtocol = MangaService()) {
        self.service = service
    }
    
    func loadMangas(sort: MangaSort? = nil) async {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        error = nil
        if let sort = sort { self.sort = sort }
        do {
            let newMangas = try await service.fetchMangas(page: currentPage, perPage: perPage, sort: self.sort)
            if newMangas.isEmpty {
                canLoadMore = false
            } else {
                mangas.append(contentsOf: newMangas)
                currentPage += 1
            }
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func changeSort(_ newSort: MangaSort) async {
        currentPage = 1
        canLoadMore = true
        mangas = []
        await loadMangas(sort: newSort)
    }
    
    func refresh() async {
        currentPage = 1
        canLoadMore = true
        mangas = []
        await loadMangas()
    }
}
