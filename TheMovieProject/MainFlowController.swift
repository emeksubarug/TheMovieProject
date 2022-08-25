//
//  MainFlowController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.08.2022.
//

import Foundation
import UIKit

final class MainFlowController {

/*
 let tabbar = StoryboardFactory.tabbar.instantiateInitial(MainTabbarController.self)
 let artistView = StoryboardFactory.artists.instantiateInitial()
 let discoverView = StoryboardFactory.discover.instantiateInitial()
 let genresView = StoryboardFactory.genres.instantiateInitial()

 tabbar.viewControllers = [discoverView, artistView,genresView].map{UINavigationController(rootViewController: $0)}
 tabbar.modalPresentationStyle = .fullScreen
 self.present(tabbar, animated: true)
 */

// MARK: - private properties
    private var mainVCFactory: MainVCFactory! = MainVCFactory()
    private var rootNavigationController: UINavigationController {
        guard let rootNav =  self.window.rootViewController as? UINavigationController else {
             fatalError("There is no root controller for window")
         }
         return rootNav
     }
// MARK: - public properties
    public static let shared = MainFlowController()
    public var window: UIWindow!

// MARK: - functions
    public func start() {
        rootNavigationController.pushViewController(mainVCFactory.container(), animated: true)
    }
    public func goToTabbar() {
        let tabbar = mainVCFactory.tabbar()
        let discover = mainVCFactory.discover()
        let artists = mainVCFactory.artists()
        let genres = mainVCFactory.genres()
        tabbar.viewControllers = [discover, artists, genres]
        rootNavigationController.pushViewController(tabbar, animated: true)
    }
}

fileprivate class MainVCFactory {

    func container() -> UIViewController {
        return StoryboardFactory.main.instantiate(ContainerViewController.self)
    }

    func tabbar() -> UITabBarController {
        return StoryboardFactory.tabbar.instantiateInitial()
    }

    func discover() -> UIViewController {
       return StoryboardFactory.discover.instantiateInitial()
   }

    func artists() -> UIViewController {
       return StoryboardFactory.artists.instantiateInitial()
   }

    func genres() -> UIViewController {
       return StoryboardFactory.genres.instantiateInitial()
   }
}
