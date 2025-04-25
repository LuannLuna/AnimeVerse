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
    var currentTab: AppRoute = .home
    var homeNavigationPath = NavigationPath()
    var favoriteNavigationPath = NavigationPath()
    var profileNavigationPath = NavigationPath()
    var presentedSheet: AppRoute?
    var presentedFullScreenCover: AppRoute?

    // Navigate to a specified route with the given presentation type
    func navigate(to route: AppRoute, using navigationType: NavigationType) {
        switch navigationType {
        case .tabBar:
            if [.home, .favorites, .profile].contains(route) {
                currentTab = route
            }

        case .push:
                switch currentTab {
                    case .home:
                        homeNavigationPath.append(route)

                    case .favorites:
                        favoriteNavigationPath.append(route)

                    case .profile:
                        profileNavigationPath.append(route)

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
            case .home:
                if !homeNavigationPath.isEmpty {
                    homeNavigationPath.removeLast()
                }
                
            case .favorites:
                if !favoriteNavigationPath.isEmpty {
                    favoriteNavigationPath.removeLast()
                }

            case .profile:
                if !profileNavigationPath.isEmpty {
                    profileNavigationPath.removeLast()
                }
                
            default:
                break
        }
    }

    func popToRoot() {
        switch currentTab {
            case .home:
                homeNavigationPath = NavigationPath()

            case .favorites:
                favoriteNavigationPath = NavigationPath()

            case .profile:
                profileNavigationPath = NavigationPath()
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
