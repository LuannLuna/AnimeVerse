// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMediaDetailsQuery: GraphQLQuery {
  public static let operationName: String = "GetMediaDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMediaDetails($id: Int!, $type: MediaType!) { Media(id: $id, type: $type) { __typename id type title { __typename ...TitleFields } description(asHtml: true) startDate { __typename ...DateFields } endDate { __typename ...DateFields } episodes duration genres averageScore popularity status coverImage { __typename ...CoverImageFields } bannerImage characters { __typename edges { __typename ...CharacterEdgeFields } } } }"#,
      fragments: [CharacterEdgeFields.self, CharacterFields.self, CoverImageFields.self, DateFields.self, TitleFields.self]
    ))

  public var id: Int
  public var type: GraphQLEnum<MediaType>

  public init(
    id: Int,
    type: GraphQLEnum<MediaType>
  ) {
    self.id = id
    self.type = type
  }

  public var __variables: Variables? { [
    "id": id,
    "type": type
  ] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Media", Media?.self, arguments: [
        "id": .variable("id"),
        "type": .variable("type")
      ]),
    ] }

    /// Media query
    public var media: Media? { __data["Media"] }

    /// Media
    ///
    /// Parent Type: `Media`
    public struct Media: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("type", GraphQLEnum<AnilistAPI.MediaType>?.self),
        .field("title", Title?.self),
        .field("description", String?.self, arguments: ["asHtml": true]),
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

      /// Media.Title
      ///
      /// Parent Type: `MediaTitle`
      public struct Title: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(TitleFields.self),
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

      /// Media.StartDate
      ///
      /// Parent Type: `FuzzyDate`
      public struct StartDate: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.FuzzyDate }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(DateFields.self),
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

      /// Media.EndDate
      ///
      /// Parent Type: `FuzzyDate`
      public struct EndDate: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.FuzzyDate }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(DateFields.self),
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

      /// Media.CoverImage
      ///
      /// Parent Type: `MediaCoverImage`
      public struct CoverImage: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(CoverImageFields.self),
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

      /// Media.Characters
      ///
      /// Parent Type: `CharacterConnection`
      public struct Characters: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge?]?.self),
        ] }

        public var edges: [Edge?]? { __data["edges"] }

        /// Media.Characters.Edge
        ///
        /// Parent Type: `CharacterEdge`
        public struct Edge: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(CharacterEdgeFields.self),
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
    }
  }
}
