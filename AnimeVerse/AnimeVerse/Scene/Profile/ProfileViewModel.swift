import Foundation
import SwiftUI
import FirebaseAuth

@Observable
class ProfileViewModel {
    var profileImage: UIImage?
    var nickname: String = ""
    var photoURL: String?
    var watchingList: [FavoriteAnimeDTO] = []
    var planningList: [FavoriteAnimeDTO] = []
    var isSaving = false
    var errorMessage: String?

    var uid: String? { Auth.auth().currentUser?.uid }

    private func updateUserData(from user: ProfileUserProtocol) {
        nickname = user.nickname
        photoURL = user.photoURL
        watchingList = user.watching
        planningList = user.planning
    }

    func syncProfile() async {
        guard let uid else { return }
        if let localUser = await LocalUserStore.shared.load() {
            updateUserData(from: localUser)
        }

        do {
            let user = try await UserService.shared.syncFromFirestore(uid: uid)
            updateUserData(from: user)
            await LocalUserStore.shared.save(LocalUser(from: user))
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveProfile() {
        guard let uid else { errorMessage = "User not logged in"; return }
        isSaving = true
        errorMessage = nil
        let user = FirestoreUser(
            id: uid,
            nickname: nickname,
            photoURL: photoURL,
            watching: watchingList,
            planning: planningList
        )
        UserService.shared.saveUser(user, profileImage: profileImage) { [weak self] error in
            Task { @MainActor in
                self?.isSaving = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.errorMessage = nil
                }
            }
        }
    }
}
