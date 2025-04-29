import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    @Environment(Router.self) private var router: Router
    @EnvironmentObject var userSession: UserSession
    @State private var viewModel = ProfileViewModel()
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 24) {
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    // Profile Image Placeholder & Nickname
                    VStack(spacing: 8) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.gray.opacity(0.5))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                            .padding(.top, 16)
                        TextField("Nickname", text: $viewModel.nickname) { viewModel.saveProfile() }
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                            .frame(maxWidth: 240)
                            .disabled(viewModel.isSaving)
                    }

                    // List Buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            router.navigate(to: .watchingList, using: .push)
                        }) {
                            Text("Watching List (\(viewModel.watchingList.count))")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.opacity(0.15))
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            // TODO: Present planning list view
                        }) {
                            Text("Planning List (\(viewModel.planningList.count)")
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
                .onAppear {
                    Task {
                        await viewModel.syncProfile()
                    }
                }
                if viewModel.isSaving {
                    Color.black.opacity(0.35)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView("Loading...")
                        .padding(32)
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(radius: 10)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserSession())
}
