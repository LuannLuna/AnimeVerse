import SwiftUI

struct RootView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        if userSession.isLoggedIn {
            MainApp()
        } else {
            LoginView()
        }
    }
}
