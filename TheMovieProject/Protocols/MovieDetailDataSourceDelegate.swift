//
//  MovieDetailDataSourceDelegate.swift
//  TheMovieProject
//
//  Created by emeksu.barug on 14.04.2022.
//

import Foundation

protocol MovieDetailDataSourceDelegate {
    func onMovieDetailLoaded(movie: Movie)
}
