// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterEdgeFields: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterEdgeFields on CharacterEdge { __typename role node { __typename ...CharacterFields } voiceActors { __typename id name { __typename full userPreferred } languageV2 image { __typename medium large } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterEdge }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("role", GraphQLEnum<AnilistAPI.CharacterRole>?.self),
    .field("node", Node?.self),
    .field("voiceActors", [VoiceActor?]?.self),
  ] }

  /// The characters role in the media
  public var role: GraphQLEnum<AnilistAPI.CharacterRole>? { __data["role"] }
  public var node: Node? { __data["node"] }
  /// The voice actors of the character
  public var voiceActors: [VoiceActor?]? { __data["voiceActors"] }

  /// Node
  ///
  /// Parent Type: `Character`
  public struct Node: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CharacterFields.self),
    ] }

    /// The id of the character
    public var id: Int { __data["id"] }
    /// The names of the character
    public var name: Name? { __data["name"] }
    /// Character images
    public var image: Image? { __data["image"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var characterFields: CharacterFields { _toFragment() }
    }

    public typealias Name = CharacterFields.Name

    public typealias Image = CharacterFields.Image
  }

  /// VoiceActor
  ///
  /// Parent Type: `Staff`
  public struct VoiceActor: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Staff }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", Int.self),
      .field("name", Name?.self),
      .field("languageV2", String?.self),
      .field("image", Image?.self),
    ] }

    /// The id of the staff member
    public var id: Int { __data["id"] }
    /// The names of the staff member
    public var name: Name? { __data["name"] }
    /// The primary language of the staff member. Current values: Japanese, English, Korean, Italian, Spanish, Portuguese, French, German, Hebrew, Hungarian, Chinese, Arabic, Filipino, Catalan, Finnish, Turkish, Dutch, Swedish, Thai, Tagalog, Malaysian, Indonesian, Vietnamese, Nepali, Hindi, Urdu
    public var languageV2: String? { __data["languageV2"] }
    /// The staff images
    public var image: Image? { __data["image"] }

    /// VoiceActor.Name
    ///
    /// Parent Type: `StaffName`
    public struct Name: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.StaffName }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("full", String?.self),
        .field("userPreferred", String?.self),
      ] }

      /// The person's first and last name
      public var full: String? { __data["full"] }
      /// The currently authenticated users preferred name language. Default romaji for non-authenticated
      public var userPreferred: String? { __data["userPreferred"] }
    }

    /// VoiceActor.Image
    ///
    /// Parent Type: `StaffImage`
    public struct Image: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.StaffImage }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("medium", String?.self),
        .field("large", String?.self),
      ] }

      /// The person's image of media at medium size
      public var medium: String? { __data["medium"] }
      /// The person's image of media at its largest size
      public var large: String? { __data["large"] }
    }
  }
}
