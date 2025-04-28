// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FindMediaQuery: GraphQLQuery {
  public static let operationName: String = "FindMedia"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query FindMedia($search: String, $page: Int, $type: MediaType) { Page(page: $page) { __typename pageInfo { __typename currentPage total hasNextPage } media(search: $search, type: $type) { __typename id type title { __typename ...TitleFields } description(asHtml: false) startDate { __typename ...DateFields } endDate { __typename ...DateFields } episodes duration genres averageScore popularity status coverImage { __typename ...CoverImageFields } bannerImage characters { __typename edges { __typename ...CharacterEdgeFields } } recommendations { __typename nodes { __typename mediaRecommendation { __typename id type title { __typename ...TitleFields } coverImage { __typename ...CoverImageFields } } } } } } }"#,
      fragments: [CharacterEdgeFields.self, CharacterFields.self, CoverImageFields.self, DateFields.self, TitleFields.self]
    ))

  public var search: GraphQLNullable<String>
  public var page: GraphQLNullable<Int>
  public var type: GraphQLNullable<GraphQLEnum<MediaType>>

  public init(
    search: GraphQLNullable<String>,
    page: GraphQLNullable<Int>,
    type: GraphQLNullable<GraphQLEnum<MediaType>>
  ) {
    self.search = search
    self.page = page
    self.type = type
  }

  public var __variables: Variables? { [
    "search": search,
    "page": page,
    "type": type
  ] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Page", Page?.self, arguments: ["page": .variable("page")])
    ] }

    public var page: Page? { __data["Page"] }

    /// Page
    ///
    /// Parent Type: `Page`
    public struct Page: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Page }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pageInfo", PageInfo?.self),
        .field("media", [Medium?]?.self, arguments: [
          "search": .variable("search"),
          "type": .variable("type")
        ])
      ] }

      /// The pagination information
      public var pageInfo: PageInfo? { __data["pageInfo"] }
      public var media: [Medium?]? { __data["media"] }

      /// Page.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("currentPage", Int?.self),
          .field("total", Int?.self),
          .field("hasNextPage", Bool?.self)
        ] }

        /// The current page
        public var currentPage: Int? { __data["currentPage"] }
        /// The total number of items. Note: This value is not guaranteed to be accurate, do not rely on this for logic
        public var total: Int? { __data["total"] }
        /// If there is another page
        public var hasNextPage: Bool? { __data["hasNextPage"] }
      }

      /// Page.Medium
      ///
      /// Parent Type: `Media`
      public struct Medium: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("type", GraphQLEnum<AnilistAPI.MediaType>?.self),
          .field("title", Title?.self),
          .field("description", String?.self, arguments: ["asHtml": false]),
          .field("startDate", StartDate?.self),
          .field("endDate", EndDate?.self),
          .field("episodes", Int?.self),
          .field("duration", Int?.self),
          .field("genres", [String?]?.self),
          .field("averageScore", Int?.self),
          .field("popularity", Int?.self),
          .field("status", GraphQLEnum<AnilistAPI.MediaStatus>?.self),
          .field("coverImage", CoverImage?.self),
          .field("bannerImage", String?.self),
          .field("characters", Characters?.self),
          .field("recommendations", Recommendations?.self)
        ] }

        /// The id of the media
        public var id: Int { __data["id"] }
        /// The type of the media; anime or manga
        public var type: GraphQLEnum<AnilistAPI.MediaType>? { __data["type"] }
        /// The official titles of the media in various languages
        public var title: Title? { __data["title"] }
        /// Short description of the media's story and characters
        public var description: String? { __data["description"] }
        /// The first official release date of the media
        public var startDate: StartDate? { __data["startDate"] }
        /// The last official release date of the media
        public var endDate: EndDate? { __data["endDate"] }
        /// The amount of episodes the anime has when complete
        public var episodes: Int? { __data["episodes"] }
        /// The general length of each anime episode in minutes
        public var duration: Int? { __data["duration"] }
        /// The genres of the media
        public var genres: [String?]? { __data["genres"] }
        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? { __data["averageScore"] }
        /// The number of users with the media on their list
        public var popularity: Int? { __data["popularity"] }
        /// The current releasing status of the media
        public var status: GraphQLEnum<AnilistAPI.MediaStatus>? { __data["status"] }
        /// The cover images of the media
        public var coverImage: CoverImage? { __data["coverImage"] }
        /// The banner image of the media
        public var bannerImage: String? { __data["bannerImage"] }
        /// The characters in the media
        public var characters: Characters? { __data["characters"] }
        /// User recommendations for similar media
        public var recommendations: Recommendations? { __data["recommendations"] }

        /// Page.Medium.Title
        ///
        /// Parent Type: `MediaTitle`
        public struct Title: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(TitleFields.self)
          ] }

          /// The romanization of the native language title
          public var romaji: String? { __data["romaji"] }
          /// The official english title
          public var english: String? { __data["english"] }
          /// Official title in it's native language
          public var native: String? { __data["native"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var titleFields: TitleFields { _toFragment() }
          }
        }

        /// Page.Medium.StartDate
        ///
        /// Parent Type: `FuzzyDate`
        public struct StartDate: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.FuzzyDate }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(DateFields.self)
          ] }

          /// Numeric Year (2017)
          public var year: Int? { __data["year"] }
          /// Numeric Month (3)
          public var month: Int? { __data["month"] }
          /// Numeric Day (24)
          public var day: Int? { __data["day"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var dateFields: DateFields { _toFragment() }
          }
        }

        /// Page.Medium.EndDate
        ///
        /// Parent Type: `FuzzyDate`
        public struct EndDate: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.FuzzyDate }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(DateFields.self)
          ] }

          /// Numeric Year (2017)
          public var year: Int? { __data["year"] }
          /// Numeric Month (3)
          public var month: Int? { __data["month"] }
          /// Numeric Day (24)
          public var day: Int? { __data["day"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var dateFields: DateFields { _toFragment() }
          }
        }

        /// Page.Medium.CoverImage
        ///
        /// Parent Type: `MediaCoverImage`
        public struct CoverImage: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(CoverImageFields.self)
          ] }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? { __data["extraLarge"] }
          /// The cover image url of the media at a large size
          public var large: String? { __data["large"] }
          /// The cover image url of the media at medium size
          public var medium: String? { __data["medium"] }
          /// Average #hex color of cover image
          public var color: String? { __data["color"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var coverImageFields: CoverImageFields { _toFragment() }
          }
        }

        /// Page.Medium.Characters
        ///
        /// Parent Type: `CharacterConnection`
        public struct Characters: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge?]?.self)
          ] }

          public var edges: [Edge?]? { __data["edges"] }

          /// Page.Medium.Characters.Edge
          ///
          /// Parent Type: `CharacterEdge`
          public struct Edge: AnilistAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterEdge }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(CharacterEdgeFields.self)
            ] }

            /// The characters role in the media
            public var role: GraphQLEnum<AnilistAPI.CharacterRole>? { __data["role"] }
            public var node: Node? { __data["node"] }
            /// The voice actors of the character
            public var voiceActors: [VoiceActor?]? { __data["voiceActors"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var characterEdgeFields: CharacterEdgeFields { _toFragment() }
            }

            public typealias Node = CharacterEdgeFields.Node

            public typealias VoiceActor = CharacterEdgeFields.VoiceActor
          }
        }

        /// Page.Medium.Recommendations
        ///
        /// Parent Type: `RecommendationConnection`
        public struct Recommendations: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.RecommendationConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node?]?.self)
          ] }

          public var nodes: [Node?]? { __data["nodes"] }

          /// Page.Medium.Recommendations.Node
          ///
          /// Parent Type: `Recommendation`
          public struct Node: AnilistAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Recommendation }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("mediaRecommendation", MediaRecommendation?.self)
            ] }

            /// The recommended media
            public var mediaRecommendation: MediaRecommendation? { __data["mediaRecommendation"] }

            /// Page.Medium.Recommendations.Node.MediaRecommendation
            ///
            /// Parent Type: `Media`
            public struct MediaRecommendation: AnilistAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", Int.self),
                .field("type", GraphQLEnum<AnilistAPI.MediaType>?.self),
                .field("title", Title?.self),
                .field("coverImage", CoverImage?.self)
              ] }

              /// The id of the media
              public var id: Int { __data["id"] }
              /// The type of the media; anime or manga
              public var type: GraphQLEnum<AnilistAPI.MediaType>? { __data["type"] }
              /// The official titles of the media in various languages
              public var title: Title? { __data["title"] }
              /// The cover images of the media
              public var coverImage: CoverImage? { __data["coverImage"] }

              /// Page.Medium.Recommendations.Node.MediaRecommendation.Title
              ///
              /// Parent Type: `MediaTitle`
              public struct Title: AnilistAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .fragment(TitleFields.self)
                ] }

                /// The romanization of the native language title
                public var romaji: String? { __data["romaji"] }
                /// The official english title
                public var english: String? { __data["english"] }
                /// Official title in it's native language
                public var native: String? { __data["native"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var titleFields: TitleFields { _toFragment() }
                }
              }

              /// Page.Medium.Recommendations.Node.MediaRecommendation.CoverImage
              ///
              /// Parent Type: `MediaCoverImage`
              public struct CoverImage: AnilistAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .fragment(CoverImageFields.self)
                ] }

                /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
                public var extraLarge: String? { __data["extraLarge"] }
                /// The cover image url of the media at a large size
                public var large: String? { __data["large"] }
                /// The cover image url of the media at medium size
                public var medium: String? { __data["medium"] }
                /// Average #hex color of cover image
                public var color: String? { __data["color"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var coverImageFields: CoverImageFields { _toFragment() }
                }
              }
            }
          }
        }
      }
    }
  }
}
