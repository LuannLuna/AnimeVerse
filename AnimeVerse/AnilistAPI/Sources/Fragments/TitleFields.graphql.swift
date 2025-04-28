// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct TitleFields: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment TitleFields on MediaTitle { __typename romaji english native }"#
  }

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
