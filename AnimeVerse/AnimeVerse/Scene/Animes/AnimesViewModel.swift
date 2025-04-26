import Foundation
import Combine

@Observable
class AnimesViewModel {
    var animes: [Anime] = []
    var isLoading: Bool = false
    var isFetchingNextPage: Bool = false
    var errorMessage: String? = nil
    private var currentPage: Int = 1
    private var perPage: Int = 100

    private let service = AnimeService()

    func loadAnimes() async {
        defer { isLoading = false }
        isLoading = true
        errorMessage = nil
        do {
            animes = try await service.fetchAnimes(page: currentPage, perPage: perPage)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadNextPageIfNeeded(item: Anime) async {
        guard !isFetchingNextPage else { return }
        guard let index = animes.firstIndex(where: { $0 == item }) else { return }
        let thresholdIndex = animes.index(animes.endIndex, offsetBy: -10, limitedBy: animes.startIndex) ?? 0
        guard index >= thresholdIndex else { return }

        isFetchingNextPage = true
        defer { isFetchingNextPage = false }
        currentPage += 1

        do {
            let newAnimes = try await service.fetchAnimes(page: currentPage, perPage: perPage)
            animes.append(contentsOf: newAnimes)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
