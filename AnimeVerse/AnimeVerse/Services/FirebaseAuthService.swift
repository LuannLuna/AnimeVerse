import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct FirebaseAuthService {
    static let shared = FirebaseAuthService()
    private init() {}

    func signUp(email: String, password: String) async throws {
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func signIn(email: String, password: String) async throws {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }

    @MainActor
    func signInWithGoogle(presentingViewController: UIViewController) async throws {
        guard let clientID = loadGoogleClientID() else {
            throw NSError(domain: "NoClientID", code: -1)
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(domain: "NoIDToken", code: -1)
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)
        _ = try await Auth.auth().signIn(with: credential)
    }

    func loadGoogleClientID() -> String? {
        return Bundle.main.infoDictionary?["GIDClientID"] as? String
    }

}
