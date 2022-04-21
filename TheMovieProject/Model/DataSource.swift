//
//  DataSource.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.01.2022.
//

import Foundation
import UIKit
import Alamofire

class DataSource {
    var upcomingMoviesList: [Movie] = []
    var popularMoviesList: [Movie] = []
    var nowPlayingMoviesList: [Movie] = []
    var delegate: DataSourceDelegate?

    func appendMovies(movie: Movie) {
    }

    func loadPopularMovies(page: Int) {
        APIClient.loadPopularMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.popularMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.delegate?.mostPopularLoaded()
            }
        }
    }

    func loadUpcomingMovies(page: Int) {
        APIClient.loadUpcomingMovies(page: page) { result in
            switch result {
            case .success(let movie):
                self.upcomingMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.upcomingLoaded()
            }
        }
    }

    func loadNowPlayingMovies(page: Int) {
        APIClient.loadNowPlayingMovies(page: page) { result in
            switch result {
            case .success(let movie):
                self.nowPlayingMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.nowPlayingLoaded()
            }
        }
    }

    func loadMovieReview() {
        APIClient.loadMovieReview(movieId: 550, page: 1 ) { result in
            switch result {
            case .success(let movie):
                print("\n review \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func loadSimilarMovies() {
        APIClient.loadSimilarMovies(movieId: 550, page: 1 ) { result in
            switch result {
            case .success(let movie):
                print("\n similar \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getPopularMovieForIndex(index: Int) -> Movie {
        let realIndex = index % popularMoviesList.count
        return popularMoviesList[realIndex]
    }

    func getUpcomingMovieForIndex(index: Int) -> Movie {
        let realIndex = index % upcomingMoviesList.count
        return upcomingMoviesList[realIndex]
    }

    func getNowPlayingMovieForIndex(index: Int) -> Movie {
        let realIndex = index % nowPlayingMoviesList.count
        return nowPlayingMoviesList[realIndex]
    }

    func getNumberOfPopularMovies() -> Int {
        return popularMoviesList.count
    }

    func getNumberOfUpcomingMovies() -> Int {
        return upcomingMoviesList.count
    }

    func getNumberOfNowPlayingMovies() -> Int {
        return nowPlayingMoviesList.count
    }
}
