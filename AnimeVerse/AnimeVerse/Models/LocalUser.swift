import Foundation

struct LocalUser: Codable, ProfileUserProtocol {
    var id: String
    var nickname: String
    var photoData: Data?
    var photoURL: String?
    var watching: [FavoriteAnimeDTO]
    var planning: [FavoriteAnimeDTO]
    var lastUpdated: Date
}

extension LocalUser {
    init(from firestoreUser: FirestoreUser) {
        self.id = firestoreUser.id
        self.nickname = firestoreUser.nickname
        self.photoURL = firestoreUser.photoURL
        self.watching = firestoreUser.watching
        self.planning = firestoreUser.planning
        self.lastUpdated = Date()
        self.photoData = nil // Photo data will be handled separately
    }
}
