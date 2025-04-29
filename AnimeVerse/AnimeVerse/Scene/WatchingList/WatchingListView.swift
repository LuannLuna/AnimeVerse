import SwiftUI

struct WatchingListView: View {
    @State private var viewModel = WatchingListViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Watching List")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else if viewModel.watchingList.isEmpty {
                Text("You are not watching any anime yet.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.watchingList, id: \.id) { anime in
                            AnimeCardView(anime: .init(from: anime))
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .navigationTitle("Watching List")
    }
}

#Preview {
    WatchingListView()
}
