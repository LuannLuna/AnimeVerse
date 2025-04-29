import Foundation

struct FirestoreUser: Codable, Identifiable {
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
