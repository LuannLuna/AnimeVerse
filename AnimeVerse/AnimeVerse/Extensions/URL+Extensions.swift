import Foundation

extension Optional where Wrapped == String {
    var asURL: URL? {
        guard let self = self else { return nil }
        return URL(string: self)
    }

    var asFileURL: URL? {
        guard let self = self else { return nil }
        return URL(fileURLWithPath: self)
    }

    func asURL(withScheme scheme: String = "https") -> URL? {
        guard let self = self else { return nil }
        if self.contains("://") {
            return URL(string: self)
        }
        return URL(string: "\(scheme)://\(self)")
    }
}

extension String {
    var asURL: URL? {
        URL(string: self)
    }

    var asFileURL: URL? {
        URL(fileURLWithPath: self)
    }

    func asURL(withScheme scheme: String = "https") -> URL? {
        if contains("://") {
            return URL(string: self)
        }
        return URL(string: "\(scheme)://\(self)")
    }
}

extension URL {
    /// Appends query parameters to the URL
    func appendingQueryParameters(_ parameters: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        let componentsQueryItems = components?.queryItems ?? []
        components?.queryItems = componentsQueryItems + queryItems
        return components?.url
    }

    /// Returns query parameters as a dictionary
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return [:]
        }
        return Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value ?? "") })
    }

    /// Checks if the URL uses HTTPS
    var isSecure: Bool {
        scheme == "https"
    }

    /// Returns the base URL (scheme + host + port)
    var baseURL: URL? {
        guard let scheme = scheme,
              let host = host else { return nil }
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        return components.url
    }

    /// Returns a URL with the last path component removed
    var deletingLastPathComponent: URL {
        deletingLastPathComponent()
    }
}
