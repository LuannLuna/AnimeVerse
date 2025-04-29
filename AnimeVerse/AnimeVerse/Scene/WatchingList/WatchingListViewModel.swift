import Foundation
import SwiftUI
import FirebaseAuth

@Observable
class WatchingListViewModel {
    var watchingList: [FavoriteAnime] = []
    var isLoading: Bool = false
    var errorMessage: String?

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

    func addToList(type: AnimeListType, mediaDetails: MediaDetails, completion: (() -> Void)? = nil) async {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not logged in."
            return
        }
        let dto = FavoriteAnimeDTO(from: FavoriteAnime(from: mediaDetails))
        isLoading = true
        errorMessage = nil
        do {
            let user = try await UserService.shared.fetchUser(uid: uid)
            var watching = user.watching
            var planning = user.planning
            if type == .watch {
                if !watching.contains(where: { $0.id == dto.id }) {
                    watching.append(dto)
                }
            } else {
                if !planning.contains(where: { $0.id == dto.id }) {
                    planning.append(dto)
                }
            }
            UserService.shared.updateLists(uid: uid, watching: watching, planning: planning) { err in
                self.isLoading = false
                if let err = err {
                    self.errorMessage = err.localizedDescription
                } else {
                    completion?()
                }
            }
        } catch {
            self.isLoading = false
            self.errorMessage = "User not found."
        }
    }
}
