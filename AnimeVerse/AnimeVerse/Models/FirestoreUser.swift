import Foundation

struct FirestoreUser: Codable, Identifiable, ProfileUserProtocol {
    let id: String // uid
    var nickname: String
    var photoURL: String?
    var watching: [FavoriteAnimeDTO]
    var planning: [FavoriteAnimeDTO]

    init(
        id: String,
        nickname: String,
        photoURL: String? = nil,
        watching: [FavoriteAnimeDTO] = [],
        planning: [FavoriteAnimeDTO] = []
    ) {
        self.id = id
        self.nickname = nickname
        self.photoURL = photoURL
        self.watching = watching
        self.planning = planning
    }
}

extension FirestoreUser {
    init(from localUser: LocalUser) {
        self.id = localUser.id
        self.nickname = localUser.nickname
        self.photoURL = localUser.photoURL
        self.watching = localUser.watching
        self.planning = localUser.planning
    }
}
