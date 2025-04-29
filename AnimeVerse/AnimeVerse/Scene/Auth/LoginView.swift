import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var showSignUp: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Button {
                    Task {
                        await signInWithEmail()
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)

                GoogleSignInButton {
                    signInWithGoogle()

                    guard let rootVC = UIApplication.shared.topMostViewController else {
                        errorMessage = "Unable to get root view controller."
                        isLoading = false
                        return
                    }
                    Task {
                        do {
                            try await FirebaseAuthService.shared.signInWithGoogle(presentingViewController: rootVC)
                            isLoading = false
                            userSession.login()
                        } catch {
                            isLoading = false
                            errorMessage = error.localizedDescription
                        }
                    }
                }
                .disabled(isLoading)

                Button("Don't have an account? Sign Up") {
                    showSignUp = true
                }
                .padding(.top)
                .sheet(isPresented: $showSignUp) {
                    SignUpView()
                }
            }
            .padding()
        }
    }

    private func signInWithEmail() async {
        isLoading = true
        errorMessage = nil
        do {
            try await FirebaseAuthService.shared.signIn(email: email, password: password)
            isLoading = false
            userSession.login()
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }

    private func signInWithGoogle() {
        isLoading = true
        errorMessage = nil
        guard let topVC = UIApplication.shared.topMostViewController else {
            errorMessage = "Unable to access top view controller."
            isLoading = false
            return
        }
        Task {
            do {
                try await FirebaseAuthService.shared.signInWithGoogle(presentingViewController: topVC)
                userSession.login()
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

#Preview {
    LoginView()
}
