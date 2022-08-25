//
//  DiscoverFlowController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 10.08.2022.
//

import Foundation
import UIKit

final class DiscoverFlowController {

    private var discoverVCFactory: DiscoverVCFactory! = DiscoverVCFactory()
    private var rootNavigationController: UINavigationController {
        guard let rootNav = self.rootNV  else {
            fatalError("no root")
        }
        return rootNav
    }

    public static let shared = DiscoverFlowController()
    public var rootNV: UINavigationController!

    public func upcomingSeeAll() {
        rootNavigationController.pushViewController(discoverVCFactory.seeAllMovies(type: .upcoming), animated: true)
    }

    public func popularSeeAll() {
        rootNavigationController.pushViewController(discoverVCFactory.seeAllMovies(type: .popular), animated: true)
    }

    public func nowPlayingSeeAll() {
        rootNavigationController.pushViewController(discoverVCFactory.seeAllMovies(type: .nowPlaying), animated: true)
    }

    public func seeMovieDetail(id: Int) {
        rootNavigationController.pushViewController(discoverVCFactory.seeMovieFromCollection(id: id), animated: true)
    }
    
    public func goToSearchPage(){
        rootNavigationController.pushViewController(discoverVCFactory.searchPage(), animated: true)
    }
}

fileprivate class DiscoverVCFactory {

    func seeAllMovies(type: MovieListType) -> UIViewController {
        let vc = StoryboardFactory.seeAll.instantiate(SeeMoviesViewController.self)
        vc.type = type
        return vc
    }
    func seeMovieFromCollection(id: Int) -> UIViewController {
        let vc = StoryboardFactory.seeMovie.instantiate(MovieDetailsViewController.self)
        vc.selectedMovieId = id
        return vc
    }
    func searchPage() -> UIViewController {
        let vc = StoryboardFactory.search.instantiate(SearchViewController.self)
        return vc
    }
}
