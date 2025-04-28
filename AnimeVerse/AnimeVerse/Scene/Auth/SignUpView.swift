import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Sign Up")
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
                        .textContentType(.newPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textContentType(.newPassword)
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
                        await signUpWithEmail()
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)

                Button("Already have an account? Sign In") {
                    dismiss()
                }
                .padding(.top)
            }
            .padding()
        }
    }

    private func signUpWithEmail() async {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            try await FirebaseAuthService.shared.signUp(email: email, password: password)
            isLoading = false
            dismiss()
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    SignUpView()
}
