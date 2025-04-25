import SwiftUI
import SwiftData

@main
struct AnimeVerseApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteAnime.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainApp()
        }
        .modelContainer(sharedModelContainer)
    }
}
