//
//  MovieUIConverter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 15.08.2022.
//

import Foundation

public class MovieUIConverter {
    static func toMovieInfoModel(from movie: Movie) -> MovieInfoModel {
        return MovieInfoModel(name: movie.originalTitle, imageURL: movie.posterPath, rating: movie.voteAverage, id: movie.id)
    }

    static func toMovieList(from movies: [Movie]?) -> [MovieInfoModel]? {
        guard let movies = movies else {
            return nil
        }

       return movies.map { movie in
           MovieUIConverter.toMovieInfoModel(from: movie)
        }
    }
}
