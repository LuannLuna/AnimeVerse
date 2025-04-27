import SwiftUI
import Kingfisher

import SwiftUI

struct MangaView: View {
    @Bindable var router: Router
    @State private var viewModel = MangaViewModel()
    @State private var isSearchPresented = false
    @State private var selectedSort: MediaSort = .scoreDesc
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.mangas.isEmpty {
                    ProgressView("Loading mangas...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error")
                            .font(.title)
                        Text(error.localizedDescription)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task { await viewModel.refresh() }
                        }
                        .padding(.top)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.mangas.isEmpty {
                    ContentUnavailableView("No Mangas Found", systemImage: "book")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.mangas) { manga in
                                MangaCardView(manga: manga)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                    .onAppear {
                                        if manga == viewModel.mangas.last {
                                            Task { await viewModel.loadMangas() }
                                        }
                                    }
                                    .onTapGesture {
                                        router.navigate(to: .mangaDetail(mangaId: manga.id), using: .push)
                                    }
                            }
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            }
                        }
                        .padding(.top)
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Mangas")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("Trending Now") { selectedSort = .trendingDesc; Task { await viewModel.changeSort(selectedSort) } }
                        Button("Most Popular") { selectedSort = .popularityDesc; Task { await viewModel.changeSort(selectedSort) } }
                        Button("Top Rated") { selectedSort = .scoreDesc; Task { await viewModel.changeSort(selectedSort) } }
                    } label: {
                        Label(selectedSort.displayName, systemImage: "arrow.up.arrow.down")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSearchPresented = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
        .sheet(isPresented: $isSearchPresented) {
            SearchView(router: router, mediaKind: .manga, isPresented: $isSearchPresented)
        }
        .task {
            await viewModel.loadMangas()
        }
    }
}

struct MangaCardView: View {
    let manga: Manga
    var body: some View {
        HStack(spacing: 16) {
            if let url = manga.coverImageURL {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(manga.titleRomaji)
                    .font(.headline)
                    .lineLimit(2)
                if let english = manga.titleEnglish {
                    Text(english)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                if let description = manga.description {
                    HTMLText(description)
                        .lineLimit(3)
                        .font(.footnote)
                }
                
                if let date = manga.startDate.date {
                    Text(date, format: Date.FormatStyle(date: .numeric, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
