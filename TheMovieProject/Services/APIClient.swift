//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

class APIClient {
    static func loadImage(moviePosterUrl: String, completion: @escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadImage(moviePosterUrl: moviePosterUrl))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadPopularMovies(page: Int, completion: @escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadPopularMovies(page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadUpcomingMovies(page: Int, completion: @escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadUpcomingMovies(page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadNowPlayingMovies(page: Int, completion:@escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadNowPlayingMovies(page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadMovieDetail(movieId: Int,
                                appendToResponse: String,
                                completion: @escaping (Result<Movie, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieDetail(movieId: movieId,
                                             appendToResponse: appendToResponse))
        .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Movie, AFError>) in
            completion(response.result)
        }
    }

    static func loadMovieReview(movieId: Int,
                                page: Int,
                                completion: @escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieReview(movieId: movieId, page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadSimilarMovies(movieId: Int,
                                  page: Int,
                                  completion: @escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieReview(movieId: movieId, page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
            }
    }

    static func loadGenre(completion: @escaping (Result<GenreResponse, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.genreList)
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<GenreResponse, AFError>) in
                completion(response.result)
            }
    }
    static func loadArtists(page: Int, completion: @escaping (Result<PopularArtists, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadArtist(page: page))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<PopularArtists, AFError>) in
                completion(response.result)
            }
    }
    static func loadArtistDetail(artistId: Int,
                                 appendToResponse: String,
                                 completion: @escaping (Result<Artist, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadArtistDetail(artistId: artistId,
                                             appendToResponse: appendToResponse))
        .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Artist, AFError>) in
            completion(response.result)
        }
    }
    static func loadArtistImageGallery(artistId: Int, completion: @escaping (Result<ArtistGallery, AFError>) -> Void) {
        print("testt")
        print(APIRouter.loadArtistImageGallery(artistId: artistId))
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadArtistImageGallery(artistId: artistId))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ArtistGallery, AFError>) in
            completion(response.result)
        }
    }
}
