import Foundation
import FirebaseFirestore

protocol WatchingListServiceProtocol {
    func fetchWatchingList(for uid: String) async throws -> [FavoriteAnimeDTO]
}

final class WatchingListService: WatchingListServiceProtocol {
    private let db = Firestore.firestore()

    func fetchWatchingList(for uid: String) async throws -> [FavoriteAnimeDTO] {
        do {
            let snapshot = try await db.collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: FirestoreUser.self)
            return user.watching
        } catch {
            throw error
        }
    }
}
