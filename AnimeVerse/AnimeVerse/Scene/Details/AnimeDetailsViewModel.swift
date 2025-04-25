import Foundation

@Observable
final class AnimeDetailsViewModel {
    var animeDetails: AnimeDetails?
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: AnimeDetailsServiceProtocol
    private let animeId: Int
    
    init(animeId: Int, service: AnimeDetailsServiceProtocol = AnimeDetailsService()) {
        self.animeId = animeId
        self.service = service
    }
    
    func loadAnimeDetails() async {
        defer { isLoading = false }
        isLoading = true
        errorMessage = nil
        
        do {
            animeDetails = try await service.fetchAnimeDetails(id: animeId)
            if animeDetails == nil {
                errorMessage = "Failed to load anime details"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
