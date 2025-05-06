// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllMediasQuery: GraphQLQuery {
  public static let operationName: String = "AllMedias"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllMedias($page: Int, $perPage: Int, $sort: [MediaSort], $type: MediaType) { Page(page: $page, perPage: $perPage) { __typename pageInfo { __typename currentPage total hasNextPage } media(type: $type, sort: $sort) { __typename id title { __typename romaji english native } description(asHtml: false) startDate { __typename year month day } coverImage { __typename large } } } }"#
    ))

  public var page: GraphQLNullable<Int>
  public var perPage: GraphQLNullable<Int>
  public var sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>
  public var type: GraphQLNullable<GraphQLEnum<MediaType>>

  public init(
    page: GraphQLNullable<Int>,
    perPage: GraphQLNullable<Int>,
    sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>,
    type: GraphQLNullable<GraphQLEnum<MediaType>>
  ) {
    self.page = page
    self.perPage = perPage
    self.sort = sort
    self.type = type
  }

  public var __variables: Variables? { [
    "page": page,
    "perPage": perPage,
    "sort": sort,
    "type": type
  ] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Page", Page?.self, arguments: [
        "page": .variable("page"),
        "perPage": .variable("perPage")
      ])
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
          "type": .variable("type"),
          "sort": .variable("sort")
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
          .field("title", Title?.self),
          .field("description", String?.self, arguments: ["asHtml": false]),
          .field("startDate", StartDate?.self),
          .field("coverImage", CoverImage?.self)
        ] }

        /// The id of the media
        public var id: Int { __data["id"] }
        /// The official titles of the media in various languages
        public var title: Title? { __data["title"] }
        /// Short description of the media's story and characters
        public var description: String? { __data["description"] }
        /// The first official release date of the media
        public var startDate: StartDate? { __data["startDate"] }
        /// The cover images of the media
        public var coverImage: CoverImage? { __data["coverImage"] }

        /// Page.Medium.Title
        ///
        /// Parent Type: `MediaTitle`
        public struct Title: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("romaji", String?.self),
            .field("english", String?.self),
            .field("native", String?.self)
          ] }

          /// The romanization of the native language title
          public var romaji: String? { __data["romaji"] }
          /// The official english title
          public var english: String? { __data["english"] }
          /// Official title in it's native language
          public var native: String? { __data["native"] }
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
            .field("year", Int?.self),
            .field("month", Int?.self),
            .field("day", Int?.self)
          ] }

          /// Numeric Year (2017)
          public var year: Int? { __data["year"] }
          /// Numeric Month (3)
          public var month: Int? { __data["month"] }
          /// Numeric Day (24)
          public var day: Int? { __data["day"] }
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
            .field("large", String?.self)
          ] }

          /// The cover image url of the media at a large size
          public var large: String? { __data["large"] }
        }
      }
    }
  }
}
