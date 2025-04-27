import Foundation

enum MediaSort: String, CaseIterable, Identifiable, Codable {
    case trendingDesc = "TRENDING_DESC"
    case popularityDesc = "POPULARITY_DESC"
    case scoreDesc = "SCORE_DESC"

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .trendingDesc: return "Trending Now"
        case .popularityDesc: return "Most Popular"
        case .scoreDesc: return "Top Rated"
        }
    }
}
