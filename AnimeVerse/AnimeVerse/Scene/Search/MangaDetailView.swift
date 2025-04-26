import SwiftUI
import Kingfisher

struct MangaDetailView: View {
    let anime: MediaDetails
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Banner or Cover
                if let bannerURL = anime.bannerImageURL ?? anime.coverImageURL {
                    GeometryReader { _ in
                        KFImage(bannerURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(height: 180)
                    .clipped()
                }
                // Title
                Text(anime.titleEnglish ?? anime.titleRomaji)
                    .font(.title)
                    .bold()
                // Genres
                if !anime.genres.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(anime.genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.secondary.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                // Description
                if let desc = anime.description {
                    Text(desc)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                // Info
                HStack(spacing: 16) {
                    if let score = anime.averageScore {
                        Label("\(score)", systemImage: "star.fill")
                    }
                    if let popularity = anime.popularity {
                        Label("\(popularity)", systemImage: "person.3.fill")
                    }
                    if let status = anime.status {
                        Label(status.capitalized, systemImage: "checkmark.seal")
                    }
                }
                // Characters
                if !anime.characters.isEmpty {
                    Text("Characters")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(anime.characters) { character in
                                VStack(spacing: 8) {
                                    if let url = character.imageURL {
                                        KFImage(url)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 120)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    Text(character.name)
                                        .font(.caption)
                                        .lineLimit(2)
                                    Text(character.role.capitalized)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    if !character.voiceActors.isEmpty {
                                        Text("VA: " + character.voiceActors.map { $0.name }.joined(separator: ", "))
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                                .frame(width: 90)
                            }
                        }
                    }
                }
            }
            .padding()
        }
//        .navigationTitle(anime.titleRomaji)
        .navigationTitle(anime.id.description)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MangaDetailView(
        anime: MediaDetails(
            id: 1,
            type: .manga,
            titleRomaji: "Boruto",
            titleEnglish: "Boruto: Naruto Next Generations",
            titleNative: "BORUTO-ボルト-",
            description: "A spin-off of Boruto: Naruto Next Generations focusing on Boruto and his team.",
            startDate: DateComponents(year: 2017, month: 4, day: 1),
            endDate: DateComponents(year: 2021, month: 4, day: 1),
            episodes: 1,
            duration: 24,
            genres: ["Action", "Comedy"],
            averageScore: 55,
            popularity: 289,
            status: "FINISHED",
            coverImageURL: nil,
            bannerImageURL: nil,
            characters: []
        )
    )
}
