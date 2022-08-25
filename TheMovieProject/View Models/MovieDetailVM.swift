//
//  MovieDetailVM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 15.05.2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos

final class MovieDetailViewModel {

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
