import SwiftUI

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

                Button(action: signInWithGoogle) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Sign in with Google")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .cornerRadius(8)
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
        // TODO: Integrate Firebase Google sign-in
        isLoading = true
        errorMessage = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            // Simulate error for now
            // errorMessage = "Google sign-in failed."
        }
    }
}

#Preview {
    LoginView()
}
