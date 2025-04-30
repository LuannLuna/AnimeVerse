import SwiftUI

struct SavedListView: View {
    @State private var viewModel: ListViewModel
    let type: AnimeListType
    init(type: AnimeListType) {
        self.type = type
        self._viewModel = State(initialValue: ListViewModel(type: type))
    }

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
                        ForEach(type == .watch ? viewModel.watchingList : viewModel.planningList, id: \.id) { anime in
                            ListItemCard(item: anime)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(type == .watch ? "Watching List" : "Planning List")
    }
}

#Preview {
    SavedListView(type: .watch)
}
