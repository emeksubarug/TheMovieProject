//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

// TODO: Alamofire should only used in one network component 
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
}
