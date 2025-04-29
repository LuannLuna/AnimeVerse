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

    func syncProfile() async {
        guard let uid else { return }
        await UserService.shared.syncFromFirestore(uid: uid) { [weak self] watching, planning, nickname, photoURL in
            guard let self else { return }
            self.nickname = nickname ?? ""
            self.photoURL = photoURL
            self.watchingList = watching
            self.planningList = planning
        }
    }

    func saveProfile() {
        guard let uid else { errorMessage = "User not logged in"; return }
        isSaving = true
        errorMessage = nil
        let user = FirestoreUser(id: uid, nickname: nickname, photoURL: photoURL, watching: watchingList, planning: planningList)
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
