import Foundation
import SwiftUI
import FirebaseAuth

class WatchingListViewModel: ObservableObject {
    @Published var watchingList: [FavoriteAnime] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let watchingListService: WatchingListServiceProtocol

    init(watchingListService: WatchingListServiceProtocol = WatchingListService()) {
        self.watchingListService = watchingListService
        loadWatchingList()
    }

    func loadWatchingList() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not logged in."
            return
        }
        isLoading = true
        errorMessage = nil
        watchingListService.fetchWatchingList(for: uid) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let dtos):
                    self?.watchingList = dtos.map { $0.toFavoriteAnime() }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
