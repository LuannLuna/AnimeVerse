import Foundation
import SwiftUI

@MainActor
class UserSession: ObservableObject {
    @AppStorage("isLoggedIn") private var storedIsLoggedIn: Bool = false
    @Published var isLoggedIn: Bool {
        didSet {
            storedIsLoggedIn = isLoggedIn
        }
    }

    init() {
        let value = AppStorage(wrappedValue: false, "isLoggedIn") // manually initialize the property wrapper
        _storedIsLoggedIn = value
        isLoggedIn = value.wrappedValue
    }

    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
