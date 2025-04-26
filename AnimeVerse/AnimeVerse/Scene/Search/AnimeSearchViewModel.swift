import Foundation

@Observable
final class AnimeSearchViewModel {
    private let service: AnimeSearchServiceProtocol
    private var currentPage = 1
    private var canLoadMore = true
    
    var searchText = ""
    var animes: [MediaDetails] = []
    var isLoading = false
    var error: Error?
    
    init(service: AnimeSearchServiceProtocol = AnimeSearchService()) {
        self.service = service
    }
    
    func search() async {
        guard !searchText.isEmpty else {
            animes = []
            return
        }
        
        isLoading = true
        error = nil
        currentPage = 1
        canLoadMore = true
        
        do {
            animes = try await service.searchAnimes(term: searchText, page: currentPage, kind: .anime)
            canLoadMore = !animes.isEmpty
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func loadMore() async {
        guard !isLoading, canLoadMore else { return }
        
        isLoading = true
        currentPage += 1
        
        do {
            let nextPage = try await service.searchAnimes(term: searchText, page: currentPage, kind: .anime)
            canLoadMore = !nextPage.isEmpty
            animes.append(contentsOf: nextPage)
        } catch {
            self.error = error
            currentPage -= 1
        }
        
        isLoading = false
    }
}
