import Foundation

@Observable
final class MangaDetailViewModel {
    var mediaDetails: MediaDetails?
    var isLoading: Bool = false
    var errorMessage: String?

    private let service: MediaDetailsServiceProtocol
    private let mangaId: Int

    init(mangaId: Int, service: MediaDetailsServiceProtocol = MediaDetailsService()) {
        self.mangaId = mangaId
        self.service = service
    }

    func loadMangaDetails() async {
        defer { isLoading = false }
        isLoading = true
        errorMessage = nil
        do {
            if let mediaResult = try await service.fetchMediaDetails(id: mangaId, kind: .manga) {
                mediaDetails = mediaResult
            }
            if mediaDetails == nil {
                errorMessage = "Failed to load manga details"
            }
        } catch {
            errorMessage = error.localizedDescription + "\n\n" + mangaId.description
        }
    }
}
