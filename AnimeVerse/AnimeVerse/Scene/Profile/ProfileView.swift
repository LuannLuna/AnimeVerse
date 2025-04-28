import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Profile")
                    .font(.largeTitle)
                    .bold()

                // Placeholder for future profile info (email, avatar, etc.)
                Text("User info coming soon...")
                    .foregroundColor(.secondary)

                Button(role: .destructive) {
                    userSession.logout()
                } label: {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 24)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserSession())
}
