import Foundation
import SwiftUI

// MARK: - Route Definition

/// Defines the available routes in the application
enum AppRoute: Hashable, Identifiable {
    var id: UUID {
        UUID(uuidString: self.hashValue.description) ?? UUID()
    }

    // Tab Bar Routes
    case animes
    case favorites
    case manga

    // Other Routes
    case details(animeId: Int)
    case mangaDetail(mangaId: Int)
}

// MARK: - Navigation Types

/// Defines how a route should be presented
enum NavigationType {
    case tabBar
    case push
    case present(style: PresentationStyle = .automatic)
    case fullScreenCover
    case sheet

    enum PresentationStyle {
        case automatic
        case overFullScreen
        case fullScreen
        case pageSheet
        case formSheet
    }
}

// MARK: - Main App Structure

struct MainApp: View {
    @State private var router = Router()

    var body: some View {
        TabView(selection: $router.currentTab) {
            NavigationStack(path: $router.homeNavigationPath) {
                AnimesView()
                    .navigationDestination(for: AppRoute.self) { route in
                        destinationView(for: route)
                    }
            }
            .tabItem { Label("Animes", systemImage: "house") }
            .tag(AppRoute.animes)

            NavigationStack(path: $router.mangaNavigationPath) {
                MangaView()
                    .navigationDestination(for: AppRoute.self) { route in
                        destinationView(for: route)
                    }
            }
            .tabItem { Label("Manga", systemImage: "book") }
            .tag(AppRoute.manga)

            NavigationStack(path: $router.favoriteNavigationPath) {
                FavoritesView()
                    .navigationDestination(for: AppRoute.self) { route in
                        destinationView(for: route)
                    }
            }
            .tabItem { Label("Favorites", systemImage: "heart") }
            .tag(AppRoute.favorites)
        }
        .environment(router)
        .sheet(item: $router.presentedSheet) { route in
            destinationView(for: route)
        }
        .fullScreenCover(item: $router.presentedFullScreenCover) { route in
            destinationView(for: route)
        }
    }

    @ViewBuilder
    func destinationView(for route: AppRoute) -> some View {
        navigationContent(for: route)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
    }

    @ViewBuilder
    private func navigationContent(for route: AppRoute) -> some View {
        switch route {
            case .animes:
                AnimesView()

            case .favorites:
                FavoritesView()

            case .manga:
                MangaView()

            case let .details(animeId):
                AnimeDetailsView(animeId: animeId)

            case let .mangaDetail(mangaId):
                MangaDetailView(mangaId: mangaId)
        }
    }
}
