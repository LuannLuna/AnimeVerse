import Foundation

protocol CacheServiceProtocol {
    func cache<T: Codable>(_ object: T, forKey key: String) throws
    func object<T: Codable>(forKey key: String) throws -> T?
    func removeObject(forKey key: String)
    func removeAll()
}

final class CacheService: CacheServiceProtocol {
    private let storage: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let expirationKey = "CacheExpiration_"
    private let defaultExpirationInterval: TimeInterval = 60 * 5 // 5 minutes

    init(
        storage: UserDefaults = .standard,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
    }

    func cache<T: Codable>(_ object: T, forKey key: String) throws {
        let data = try encoder.encode(object)
        storage.set(data, forKey: key)
        storage.set(Date().timeIntervalSince1970 + defaultExpirationInterval, forKey: expirationKey + key)
    }

    func object<T: Codable>(forKey key: String) throws -> T? {
        guard
            let expirationDate = storage.double(forKey: expirationKey + key) as Double?,
            Date().timeIntervalSince1970 < expirationDate,
            let data = storage.data(forKey: key)
        else {
            removeObject(forKey: key)
            return nil
        }

        return try decoder.decode(T.self, from: data)
    }

    func removeObject(forKey key: String) {
        storage.removeObject(forKey: key)
        storage.removeObject(forKey: expirationKey + key)
    }

    func removeAll() {
        storage.dictionaryRepresentation().keys.forEach { key in
            if key.hasPrefix(expirationKey) || storage.object(forKey: key) is Data {
                storage.removeObject(forKey: key)
            }
        }
    }
}

#if DEBUG
final class CacheServiceMock: CacheServiceProtocol {
    var cachedObjects: [String: Any] = [:]
    var shouldThrowError = false

    func cache<T: Codable>(_ object: T, forKey key: String) throws {
        if shouldThrowError { throw NSError(domain: "MockError", code: -1) }
        cachedObjects[key] = object
    }

    func object<T: Codable>(forKey key: String) throws -> T? {
        if shouldThrowError { throw NSError(domain: "MockError", code: -1) }
        return cachedObjects[key] as? T
    }

    func removeObject(forKey key: String) {
        cachedObjects.removeValue(forKey: key)
    }

    func removeAll() {
        cachedObjects.removeAll()
    }
}
#endif
