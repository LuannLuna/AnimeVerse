import Foundation

@Observable
final class SearchViewModel {
    private let service: MediaSearchServiceProtocol
    private var currentPage = 1
    private var canLoadMore = true
    
    var searchText = ""
    var medias: [MediaDetails] = []
    var isLoading = false
    var error: Error?
    
    init(service: MediaSearchServiceProtocol = SearchService()) {
        self.service = service
    }
    
    func search() async {
        guard !searchText.isEmpty else {
            medias = []
            return
        }
        
        isLoading = true
        error = nil
        currentPage = 1
        canLoadMore = true
        
        do {
            medias = try await service.searchMedia(term: searchText, page: currentPage, kind: .anime)
            canLoadMore = !medias.isEmpty
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
            let nextPage = try await service.searchMedia(term: searchText, page: currentPage, kind: .anime)
            canLoadMore = !nextPage.isEmpty
            medias.append(contentsOf: nextPage)
        } catch {
            self.error = error
            currentPage -= 1
        }
        
        isLoading = false
    }
}
