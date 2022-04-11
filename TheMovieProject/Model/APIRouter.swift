//
//  APIRouter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case loadPopularMovies(language: String, page: Int, region: String)
    case loadUpcomingMovies(language: String, page: Int, region: String)
    case loadNowPlayingMovies(language: String, page: Int, region: String)
    case loadMovieDetail(movieId: Int, language: String, appendToResponse: String)
    case loadMovieReview(movieId: Int, language: String, page: Int)
    case loadSimilarMovies(movieId: Int, language: String, page: Int)
    case loadImage(moviePosterUrl: String)
    case genreList

    // MARK: - HTTPMethod

    private var method: HTTPMethod {
        switch self {
        case .loadPopularMovies:
            return .get
        case .loadUpcomingMovies:
            return .get
        case .loadNowPlayingMovies:
            return .get
        case .loadMovieDetail:
            return .get
        case .loadMovieReview:
            return .get
        case .loadSimilarMovies:
            return .get
        case .loadImage:
            return .get
        case .genreList:
            return .get
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .loadPopularMovies:
            return "/movie/popular"
        case .loadUpcomingMovies:
            return "/movie/upcoming"
        case .loadNowPlayingMovies:
            return "/movie/now_playing"
        case .loadMovieDetail(let movieId, _, _):
            return "/movie/\(movieId)"
        case .loadMovieReview(let movieId, _, _):
            return "/movie/\(movieId)/reviews"
        case .loadSimilarMovies(let movieId, _, _):
            return "/movie/\(movieId)/similar"
        case .loadImage(let moviePosterUrl):
            return "\(moviePosterUrl)"
        case .genreList:
            return "/genre/movie/list"
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        var returnPrm: Parameters = ["api_key": Constants.ProductionServer.apiKey]
        switch self {
        case .loadPopularMovies(let language, let page, _),
                .loadUpcomingMovies(let language, let page, _),
                .loadNowPlayingMovies(let language, let page, _):
            returnPrm[Constants.APIParameterKey.page] = page
            returnPrm["language"] = language

        case .loadMovieDetail(let movieId, let language, let appendToResponse):
            returnPrm["movieId"] = movieId
            returnPrm["language"] = language
            returnPrm["appendToResponse"] = appendToResponse
        case .loadMovieReview(_, let language, let page):
            returnPrm[Constants.APIParameterKey.page] = page
            returnPrm["language"] = language
        case .loadSimilarMovies(_, let language, let page):
            returnPrm[Constants.APIParameterKey.page] = page
            returnPrm["language"] = language
        case .loadImage(moviePosterUrl: _):
            return [:]
        case .genreList:
            break
        }

        return returnPrm
    }

    private var baseURL: String {
        switch self {
        case .loadPopularMovies(language: _, page: _, region: _):
            return Constants.ProductionServer.baseURL
        case .loadUpcomingMovies(language: _, page: _, region: _):
            return Constants.ProductionServer.baseURL
        case .loadNowPlayingMovies(language: _, page: _, region: _):
            return Constants.ProductionServer.baseURL
        case .loadMovieDetail(movieId: _, language: _, appendToResponse: _):
            return Constants.ProductionServer.baseURL
        case .loadMovieReview(movieId: _, language: _, page: _):
            return Constants.ProductionServer.baseURL
        case .loadSimilarMovies(movieId: _, language: _, page: _):
            return Constants.ProductionServer.baseURL
        case .loadImage(moviePosterUrl: _):
            return Constants.ProductionServer.imageURL
        case .genreList:
            return Constants.ProductionServer.baseURL
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try self.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            if method == HTTPMethod.post {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            } else if method == HTTPMethod.get {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
                print("urlrequest")
                print(urlRequest)
            }
        }
        return urlRequest
    }

}
