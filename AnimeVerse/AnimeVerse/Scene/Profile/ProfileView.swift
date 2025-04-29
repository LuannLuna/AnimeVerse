import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    @State private var nickname: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Profile Image & Change Button
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomTrailing) {
                        Group {
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray.opacity(0.5))
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))

                        Button(action: { showImagePicker = true }) {
                            Image(systemName: "camera.fill")
                                .padding(8)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .offset(x: 5, y: 5)
                    }
                    .padding(.top, 16)
                    TextField("Nickname", text: $nickname)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .frame(maxWidth: 240)
                }

                // List Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        // Navigate to Watching List
                    }) {
                        Text("Watching List")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.opacity(0.15))
                            .foregroundColor(Color.accentColor)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        // Navigate to Planning List
                    }) {
                        Text("Planning List")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.opacity(0.15))
                            .foregroundColor(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: 400)

                Spacer()

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
            }
            .padding()
            .navigationTitle("Profile")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileImage)
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserSession())
}

#Preview {
    ProfileView()
        .environmentObject(UserSession())
}
