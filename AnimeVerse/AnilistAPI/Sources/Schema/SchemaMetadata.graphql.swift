// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == AnilistAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == AnilistAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == AnilistAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == AnilistAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Character": return AnilistAPI.Objects.Character
    case "CharacterConnection": return AnilistAPI.Objects.CharacterConnection
    case "CharacterEdge": return AnilistAPI.Objects.CharacterEdge
    case "CharacterImage": return AnilistAPI.Objects.CharacterImage
    case "CharacterName": return AnilistAPI.Objects.CharacterName
    case "FuzzyDate": return AnilistAPI.Objects.FuzzyDate
    case "Media": return AnilistAPI.Objects.Media
    case "MediaCoverImage": return AnilistAPI.Objects.MediaCoverImage
    case "MediaTitle": return AnilistAPI.Objects.MediaTitle
    case "Page": return AnilistAPI.Objects.Page
    case "PageInfo": return AnilistAPI.Objects.PageInfo
    case "Query": return AnilistAPI.Objects.Query
    case "Recommendation": return AnilistAPI.Objects.Recommendation
    case "RecommendationConnection": return AnilistAPI.Objects.RecommendationConnection
    case "Staff": return AnilistAPI.Objects.Staff
    case "StaffImage": return AnilistAPI.Objects.StaffImage
    case "StaffName": return AnilistAPI.Objects.StaffName
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
