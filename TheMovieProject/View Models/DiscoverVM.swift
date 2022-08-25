//
//  Discover VM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.04.2022.
//

import Foundation
import Alamofire // remove this update APICLient

final class DiscoverViewModel {
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    var upcomingMoviesList: [Movie] = []
    var popularMoviesList: [Movie] = []
    var nowPlayingMoviesList: [Movie] = []
    var movieBlock: [MovieBlockModel] = []

    init() {
        self.state = .idle
    }

    var numberOfUpcomingMovies: Int {
        upcomingMoviesList.count
    }
    var numberOfPopularMovies: Int {
        popularMoviesList.count
    }
    var numberOfNowPlayingMovies: Int {
        nowPlayingMoviesList.count
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

    //TODO: put tupples into a model

    func getInfoPopularMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = popularMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle, imageURL: movie.posterPath, rating: movie.voteAverage)
    }
    func getInfoUpcomingMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = upcomingMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle,
                              imageURL: movie.posterPath,
                              rating: movie.voteAverage,
                              id: movie.id)
    }
    func getInfoNowPlayingMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = nowPlayingMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle,
                              imageURL: movie.posterPath,
                              rating: movie.voteAverage,
                              id: movie.id)
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
    
    func getMovieBlocks() {
        let group = DispatchGroup()
        self.state = .loading
        MovieListType.allCases.forEach { type in
            group.enter()
            loadMovies(type: type) { [weak self] movies in
                if let movies = movies {
                    self?.movieBlock.append(MovieBlockModel(type: type, movies: movies ))
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()) { [weak self] in
            self?.state = .success
        }
    }

    func loadMovies(type: MovieListType, completion: @escaping ([MovieInfoModel]?) -> Void) {
        switch type {
        case .upcoming:
            APIClient.loadUpcomingMovies(page: 1) { [weak self] result in
                switch result {
                case .success(let movie):
                    self?.upcomingMoviesList.append(contentsOf: movie.results!)
                    completion(MovieUIConverter.toMovieList(from: self?.upcomingMoviesList))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
               }
            }
        case .popular:
            APIClient.loadPopularMovies(page: 1) { [weak self] result in
                switch result {
                case .success(let movie):
                    self?.popularMoviesList.append(contentsOf: movie.results!)
                    completion(MovieUIConverter.toMovieList(from: self?.popularMoviesList))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        case .nowPlaying:
            APIClient.loadNowPlayingMovies(page: 1) { [weak self] result in
                switch result {
                case .success(let movie):
                    self?.nowPlayingMoviesList.append(contentsOf: movie.results!)
                    completion(MovieUIConverter.toMovieList(from: self?.nowPlayingMoviesList))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }

    func getMovies(type: MovieListType) -> [Movie]? {
        var movies: [Movie]?
        let completion: (Result<Results, AFError>) -> Void = { result in
            switch result {
            case .success(let movie):
                movies = movie.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        switch type {
        case .upcoming:
            APIClient.loadUpcomingMovies(page: 1, completion: completion)
        case .popular:
            APIClient.loadPopularMovies(page: 1, completion: completion)
        case .nowPlaying:
            APIClient.loadNowPlayingMovies(page: 1, completion: completion)
        }
        return movies
    }
}
