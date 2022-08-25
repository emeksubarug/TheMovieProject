//
//  StoryboardFactory.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.06.2022.
//

import UIKit

public enum StoryboardFactory: String {
    case main = "Main"
    case discover = "DiscoverView"
    case tabbar = "TabBarView"
    case artists = "ArtistsView"
    case genres = "GenresView"
    case seeAll = "MoviesAllView"
    case seeMovie = "MovieDetailView"
    case search = "SearchView"

    public func storyboard(bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: bundle)
    }

    public func instantiateInitial<VC: UIViewController>(_ viewController: VC.Type=VC.self, inBundle bundle: Bundle? = nil) -> VC {
        let storyboard = self.storyboard(bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self)) from \(self.rawValue)")
        }
        return viewController
    }

    public func instantiate<VC: UIViewController>(_ viewController: VC.Type=VC.self, inBundle bundle: Bundle? = nil) -> VC {
        let storyboard = self.storyboard(bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: VC.self)) as? VC else {
            fatalError("Couldn't instantiate \(String(describing: VC.self)) from \(self.rawValue)")
        }
        return viewController
    }
    
}
