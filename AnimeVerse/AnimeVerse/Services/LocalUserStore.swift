import Foundation

@globalActor
actor LocalUserStore {
    static let shared = LocalUserStore()
    private let userDefaultsKey = "localUserProfile"
    private init() {}

    func save(_ user: LocalUser) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func load() -> LocalUser? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return nil }
        return try? JSONDecoder().decode(LocalUser.self, from: data)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
