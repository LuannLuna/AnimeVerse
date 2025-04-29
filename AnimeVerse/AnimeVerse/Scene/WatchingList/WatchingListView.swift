import SwiftUI

struct WatchingListView: View {
    @State private var viewModel = WatchingListViewModel()
    let columns = Array(repeating: GridItem(.flexible()), count: 1)

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
                    LazyVStack(alignment: .center, spacing: 4) {
                        ForEach(viewModel.watchingList, id: \.id) { anime in
                            WatchListItemCard(item: anime)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Watching List")
    }
}

#Preview {
    WatchingListView()
}
