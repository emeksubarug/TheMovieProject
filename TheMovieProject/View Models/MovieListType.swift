//
//  MovieListType.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 29.04.2022.
//

import Foundation

enum MovieListType: CustomStringConvertible, CaseIterable {
    case upcoming
    case popular
    case nowPlaying
    
    var description: String {
        switch self {
        case .upcoming: return "Upcoming Movies"
        case .popular: return "Popular Movies"
        case .nowPlaying: return "Now Playing Movies"
        }
    }
    var category: String {
        switch self {
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        case .nowPlaying: return "Now Playing"
        }
    }
    var section: Int {
        switch self {
        case .upcoming: return 0
        case .popular: return 1
        case .nowPlaying: return 2
        }
    }
}
