import Foundation

@Observable
final class MangaViewModel {
    private let service: MangaServiceProtocol
    private(set) var mangas: [Manga] = []
    private(set) var isLoading = false
    private(set) var error: Error?
    private var currentPage = 1
    private let perPage = 20
    private var canLoadMore = true
    private var sort: MediaSort = .scoreDesc

    init(service: MangaServiceProtocol = MangaService()) {
        self.service = service
    }

    func loadMangas(sort: MediaSort? = nil) async {
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

    func changeSort(_ newSort: MediaSort) async {
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
