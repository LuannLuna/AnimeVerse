import Foundation
import FirebaseFirestore

protocol WatchingListServiceProtocol {
    func fetchWatchingList(for uid: String, completion: @escaping (Result<[FavoriteAnimeDTO], Error>) -> Void)
}

final class WatchingListService: WatchingListServiceProtocol {
    private let db = Firestore.firestore()

    func fetchWatchingList(for uid: String, completion: @escaping (Result<[FavoriteAnimeDTO], Error>) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let snapshot = snapshot else {
                completion(.success([]))
                return
            }

            do {
                let user = try snapshot.data(as: FirestoreUser.self)
                completion(.success(user.watching))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
