import SwiftUI

/// A reusable button for adding an anime to the watch list or planning list.
import FirebaseAuth

struct AddToListButton: View {
    @Binding var isPresentingModal: Bool
    let mediaDetails: MediaDetails?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showSuccess = false

    var body: some View {
        Button(action: {
            isPresentingModal = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
                Text("Add to List")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.blue.opacity(0.8))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Add to watch or planning list")
    }
}

/// Modal sheet for selecting which list to add to.
struct AddToListModal: View {
    @Binding var isPresented: Bool
    var onSelect: (AnimeListType) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Add to...")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 24)
                Button(action: {
                    onSelect(.watch)
                    isPresented = false
                }) {
                    HStack {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.blue)
                        Text("Watch List")
                            .foregroundColor(.primary)
                            .fontWeight(.medium)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.15))
                    .cornerRadius(10)
                }
                Button(action: {
                    onSelect(.planning)
                    isPresented = false
                }) {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                            .foregroundColor(.blue)
                        Text("Planning List")
                            .foregroundColor(.primary)
                            .fontWeight(.medium)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.15))
                    .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#if DEBUG
// MARK: - Previews
struct PreviewWrapper: View {
    @State private var showModal = false
    @State private var selected: AnimeListType?
    var body: some View {
        VStack(spacing: 24) {
            AddToListButton(isPresentingModal: $showModal, mediaDetails: MediaDetails.mock)
            if let selected = selected {
                Text("Selected: \(selected == .watch ? "Watch List" : "Planning List")")
            }
        }
        .sheet(isPresented: $showModal) {
            AddToListModal(isPresented: $showModal) { type in
                Task {
                    await SavedListViewModel().addToList(type: type, mediaDetails: MediaDetails.mock)
                }
                self.selected = type
            }
        }
    }
}

#Preview {
    PreviewWrapper()
        .padding()
        .background(Color(.systemGroupedBackground))
}

// MARK: - Mock for Preview
extension MediaDetails {
    static let mock = MediaDetails(
        id: 1,
        type: .anime,
        titleRomaji: "Mock Anime",
        titleEnglish: "Mock Anime English",
        titleNative: "モックアニメ",
        description: "A mock description.",
        startDate: DateComponents(),
        endDate: nil,
        episodes: 12,
        duration: 24,
        genres: ["Action", "Adventure"],
        averageScore: 87,
        popularity: 10000,
        status: "FINISHED",
        coverImageURL: nil,
        bannerImageURL: nil,
        characters: [],
        recommendations: []
    )
}

#endif
