//
//  DataSourceDelegate.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 21.01.2022.
//

import Foundation
protocol DataSourceDelegate {
    func mostPopularLoaded()
    func upcomingLoaded()
    func nowPlayingLoaded()
}
