//
//  Router.swift
//  AnimeVerse
//
//  Created by Luann Luna on 15/04/25.
//

import SwiftUI

/// Main router class that handles navigation
@Observable
class Router {
    var currentTab: AppRoute = .animes
    var homeNavigationPath = NavigationPath()
    var favoriteNavigationPath = NavigationPath()
    var mangaNavigationPath = NavigationPath()
    var presentedSheet: AppRoute?
    var presentedFullScreenCover: AppRoute?

    // Navigate to a specified route with the given presentation type
    func navigate(to route: AppRoute, using navigationType: NavigationType) {
        switch navigationType {
        case .tabBar:
            if [.animes, .favorites, .manga].contains(route) {
                currentTab = route
            }

        case .push:
                switch currentTab {
                    case .animes:
                        homeNavigationPath.append(route)

                    case .favorites:
                        favoriteNavigationPath.append(route)

                    case .manga:
                        mangaNavigationPath.append(route)

                    default:
                        break
                }

        case .present(let style):
            presentSheet(route: route, style: style)

        case .sheet:
            presentedSheet = route

        case .fullScreenCover:
            presentedFullScreenCover = route
        }
    }

    // Present a sheet with the specified style
    private func presentSheet(route: AppRoute, style: NavigationType.PresentationStyle) {
        switch style {
        case .automatic, .pageSheet, .formSheet:
            presentedSheet = route

        case .fullScreen, .overFullScreen:
            presentedFullScreenCover = route
        }
    }

    // Go back one step in the navigation hierarchy
    func goBack() {
        switch currentTab {
            case .animes:
                if !homeNavigationPath.isEmpty {
                    homeNavigationPath.removeLast()
                }

            case .favorites:
                if !favoriteNavigationPath.isEmpty {
                    favoriteNavigationPath.removeLast()
                }

            case .manga:
                if !mangaNavigationPath.isEmpty {
                    mangaNavigationPath.removeLast()
                }

            default:
                break
        }
    }

    func popToRoot() {
        switch currentTab {
            case .animes:
                homeNavigationPath = NavigationPath()

            case .favorites:
                favoriteNavigationPath = NavigationPath()

            case .manga:
                mangaNavigationPath = NavigationPath()
            default:
                break
        }
    }

    // Dismiss presented content
    func dismiss() {
        presentedSheet = nil
        presentedFullScreenCover = nil
    }
}
