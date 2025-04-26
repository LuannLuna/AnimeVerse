# AnimeVerse

AnimeVerse is a modern SwiftUI app for discovering, searching, and managing your favorite anime. Powered by the AniList GraphQL API, AnimeVerse provides a beautiful, fast, and interactive experience for anime fans to explore titles, view details, and curate a personal favorites list—all in an intuitive native interface.

---

## ✨ Features

- **Browse Trending Anime:** Discover popular and trending anime with rich visuals.
- **Advanced Search:** Find anime by title, with instant search and pagination.
- **Detailed Anime Pages:** View synopses, cover images, banners, character info, and more.
- **Favorites Management:** Add and remove anime from your favorites, stored locally.
- **Offline Access:** Favorites are available even when offline.
- **Smooth UI:** Built with SwiftUI, Kingfisher for images, and Apollo for GraphQL queries.

---

## 📸 Screenshots

<!-- Add screenshots here -->

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- macOS 13+
- Swift 5.9+

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/AnimeVerse.git
   ```
2. **Open the project:**
   - Open `AnimeVerse.xcodeproj` in Xcode.
3. **Install dependencies:**
   - The project uses Swift Package Manager. Dependencies will resolve automatically.
4. **Build and run:**
   - Select a simulator or device and hit `Run` (⌘R).

---

## 🛠️ Technologies Used

- **SwiftUI** – Declarative UI framework
- **Apollo iOS** – GraphQL networking
- **Kingfisher** – Image downloading & caching
- **AniList API** – Anime data source
- **SwiftData** – Local data persistence for favorites

---

## 📁 Project Structure

```
AnimeVerse/
├── AnimeVerse/            # Main app target
│   ├── Components/        # Reusable SwiftUI views (AnimeCard, CharacterCard, etc)
│   ├── Models/            # Data models (Anime, AnimeDetails, etc)
│   ├── Network/           # Networking & GraphQL services
│   ├── Scene/             # Main app screens (Home, Search, Details, Favorites)
│   ├── Navigation/        # Routing and navigation logic
│   ├── Extensions/        # Swift extensions
│   ├── GraphQL/           # GraphQL queries & schema
│   └── ...
├── AnilistAPI/            # Generated GraphQL API code
├── AnimeVerseTests/       # Unit tests
├── AnimeVerseUITests/     # UI tests
├── apollo-codegen-config.json # Apollo config
└── README.md
```

---

## 🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request for improvements or new features.

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

