// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CoverImageFields: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CoverImageFields on MediaCoverImage { __typename extraLarge large medium color }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("extraLarge", String?.self),
    .field("large", String?.self),
    .field("medium", String?.self),
    .field("color", String?.self),
  ] }

  /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
  public var extraLarge: String? { __data["extraLarge"] }
  /// The cover image url of the media at a large size
  public var large: String? { __data["large"] }
  /// The cover image url of the media at medium size
  public var medium: String? { __data["medium"] }
  /// Average #hex color of cover image
  public var color: String? { __data["color"] }
}
