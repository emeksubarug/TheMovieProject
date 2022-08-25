//
//  MovieDetailDataSource.swift
//  TheMovieProject
//
//  Created by emeksu.barug on 14.04.2022.
//

import Foundation

class MovieDetailDataSource {

    var delegate: MovieDetailDataSourceDelegate?

    func loadMovieDetail(movieId: Int) {
        APIClient.loadMovieDetail(movieId: movieId, appendToResponse: "credits") { [weak self] result in
            switch result {
            case .success(let movie):
                self?.delegate?.onMovieDetailLoaded(movie: movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
