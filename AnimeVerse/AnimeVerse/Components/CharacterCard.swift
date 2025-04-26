import SwiftUI
import Kingfisher

struct CharacterCard: View {
    let character: MediaDetails.Character
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = character.imageURL {
                KFImage(imageURL)
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .fade(duration: 0.25)
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.caption)
                    .bold()
                    .lineLimit(2)
                
                Text(character.role)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(width: 120)
        }
    }
}

#Preview("Character Card") {
    ScrollView(.horizontal) {
        LazyHStack(spacing: 16) {
            // Preview with different character variations
            CharacterCard(character: .init(
                id: 1,
                name: "Demon Slime",
                imageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx188889-9mNMLHCXJmUw.png"),
                role: "Main",
                voiceActors: []
            ))
            
            CharacterCard(character: .init(
                id: 2,
                name: "Tentacle Trap Master",
                imageURL: nil, // Testing without image
                role: "Supporting",
                voiceActors: []
            ))
            
            CharacterCard(character: .init(
                id: 3,
                name: "A Character with a Very Long Name That Should be Truncated",
                imageURL: URL(string: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx188889-9mNMLHCXJmUw.png"),
                role: "Background",
                voiceActors: []
            ))
        }
        .padding()
    }
}
