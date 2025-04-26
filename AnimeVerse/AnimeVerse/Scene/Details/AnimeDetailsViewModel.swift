import Foundation

@Observable
final class AnimeDetailsViewModel {
    var mediaDetails: MediaDetails?
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: MediaDetailsServiceProtocol
    private let animeId: Int
    
    init(animeId: Int, service: MediaDetailsServiceProtocol = MediaDetailsService()) {
        self.animeId = animeId
        self.service = service
    }
    
    func loadAnimeDetails() async {
        defer { isLoading = false }
        isLoading = true
        errorMessage = nil
        
        do {
            if let mediaResult = try await service.fetchMediaDetails(id: animeId, kind: .anime) {
                mediaDetails = mediaResult
            }
            if mediaDetails == nil {
                errorMessage = "Failed to load anime details"
            }
        } catch {
            errorMessage = error.localizedDescription + "\n\n" + animeId.description
        }
    }
}
