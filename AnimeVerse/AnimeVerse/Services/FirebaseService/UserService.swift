import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

struct UserService {
    static let shared = UserService()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private init() {}

    // MARK: - Save/Update User
    func saveUser(_ user: FirestoreUser, profileImage: UIImage?, completion: @escaping (Error?) -> Void) {
        // TODO: Fix logic of upload imagem and save url
//        if let image = profileImage, let imageData = image.jpegData(compressionQuality: 0.8) {
//            let ref = storage.reference().child("profileImages/\(user.id).jpg")
//            ref.putData(imageData, metadata: nil) { _, error in
//                if let error = error { completion(error); return }
//                ref.downloadURL { url, error in
//                    if let url = url {
//                        var userWithPhoto = user
//                        userWithPhoto.photoURL = url.absoluteString
//                        self.saveUserDocument(userWithPhoto, completion: completion)
//                    } else {
//                        completion(error)
//                    }
//                }
//            }
//        } else {
            saveUserDocument(user, completion: completion)
//        }
    }

    private func saveUserDocument(_ user: FirestoreUser, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("users").document(user.id).setData(from: user, merge: true, completion: completion)
        } catch {
            completion(error)
        }
    }

    // MARK: - Fetch User
    private
    func fetchUser(uid: String) async throws -> FirestoreUser {
        let document = try await db.collection("users").document(uid).getDocument()

        do {
            return try document.data(as: FirestoreUser.self)
        } catch {
            throw NSError(
                domain: "FirestoreUserError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "User document is empty or malformed"]
            )
        }
    }

    // MARK: - Sync (Download and Update Local)
    func syncFromFirestore(uid: String) async throws -> FirestoreUser {
        do {
            return try await fetchUser(uid: uid)
        } catch {
            throw error
        }
    }

    // MARK: - Update Lists Only
    func updateLists(uid: String, watching: [FavoriteAnimeDTO], planning: [FavoriteAnimeDTO], completion: @escaping (Error?) -> Void) {
        db.collection("users").document(uid).updateData([
            "watching": watching.map { try! Firestore.Encoder().encode($0) },
            "planning": planning.map { try! Firestore.Encoder().encode($0) }
        ], completion: completion)
    }

    // MARK: - Update Nickname
    func updateNickname(uid: String, nickname: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(uid).updateData(["nickname": nickname], completion: completion)
    }

    // MARK: - Update Photo URL
    func updatePhotoURL(uid: String, photoURL: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(uid).updateData(["photoURL": photoURL], completion: completion)
    }
}
