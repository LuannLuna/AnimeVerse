protocol ProfileUserProtocol {
    var id: String { get }
    var nickname: String { get }
    var photoURL: String? { get }
    var watching: [FavoriteAnimeDTO] { get }
    var planning: [FavoriteAnimeDTO] { get }
}
