import Foundation
import FirebaseAuth

class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    private init() {}

    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) async throws {
        do {
            let data = try await Auth.auth().signIn(withEmail: email, password: password)
            completion(.success("Deu bom!"))
        } catch {
            completion(.failure(error))
        }
    }
}
