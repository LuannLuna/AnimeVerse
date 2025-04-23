import Foundation

struct Anime: Identifiable, Equatable {
    let id: Int
    let titleRomaji: String
    let titleEnglish: String?
    let titleNative: String
    let startDate: DateComponents
    let coverImageURL: URL
}
