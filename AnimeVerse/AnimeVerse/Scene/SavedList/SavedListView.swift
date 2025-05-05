import SwiftUI

struct SavedListView: View {
    @State private var viewModel: SavedListViewModel
    let type: AnimeListType
    init(type: AnimeListType) {
        self.type = type
        self._viewModel = State(initialValue: SavedListViewModel(type: type))
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .center, spacing: 4) {
                        ForEach(type == .watch ? viewModel.watchingList : viewModel.planningList, id: \.id) { anime in
                            ListItemCard(item: anime)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                switch type {
                    case .watch:
                        if viewModel.watchingList.isEmpty {
                           Text("You are not watching any anime yet.")
                               .foregroundColor(.secondary)
                               .padding()
                       }
                    case .planning:
                        if viewModel.planningList.isEmpty {
                           Text("You are not planning any anime yet.")
                               .foregroundColor(.secondary)
                               .padding()
                       }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(type == .watch ? "Watching List" : "Planning List")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SavedListView(type: .watch)
}
