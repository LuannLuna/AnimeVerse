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
            guard let data = snapshot?.data(),
                  let jsonData = try? JSONSerialization.data(withJSONObject: data),
                  let user = try? JSONDecoder().decode(FirestoreUser.self, from: jsonData)
            else {
                completion(.success([]))
                return
            }
            completion(.success(user.watching))
        }
    }
}
