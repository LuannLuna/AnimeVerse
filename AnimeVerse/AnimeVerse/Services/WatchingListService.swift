import Foundation
import FirebaseFirestore

protocol FetchListServiceProtocol {
    func fetchList(for uid: String, listType type: AnimeListType) async throws -> ([FavoriteAnimeDTO], [FavoriteAnimeDTO])
}

struct FetchListService: FetchListServiceProtocol {
    private let db = Firestore.firestore()

    func fetchList(for uid: String, listType type: AnimeListType) async throws -> ([FavoriteAnimeDTO], [FavoriteAnimeDTO]) {
        do {
            let snapshot = try await db.collection("users")
                .document(uid)
                .getDocument()
            let user = try snapshot.data(as: FirestoreUser.self)
            return (user.watching, user.planning)
        } catch {
            throw error
        }
    }
}
