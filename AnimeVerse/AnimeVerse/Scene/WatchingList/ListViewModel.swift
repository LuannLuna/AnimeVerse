import Foundation
import SwiftUI
import FirebaseAuth

@Observable
class ListViewModel {
    var watchingList: [FavoriteAnime] = []
    var planningList: [FavoriteAnime] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var type: AnimeListType
    let service = FetchListService()

    init(type: AnimeListType = .watch) {
        self.type = type
        Task {
            await loadWatchingList()
        }
    }

    func loadWatchingList() async {
        defer { isLoading = false }
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not logged in."
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let dtos = try await service.fetchList(for: uid, listType: type)
            watchingList = dtos.0.map { $0.toFavoriteAnime() }
            planningList = dtos.1.map { $0.toFavoriteAnime() }
        } catch {
            errorMessage = error.localizedDescription
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
