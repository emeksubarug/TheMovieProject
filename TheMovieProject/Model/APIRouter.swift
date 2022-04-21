//
//  APIRouter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case loadPopularMovies(page: Int)
    case loadUpcomingMovies(page: Int)
    case loadNowPlayingMovies(page: Int)
    case loadMovieDetail(movieId: Int, appendToResponse: String)
    case loadMovieReview(movieId: Int, page: Int)
    case loadSimilarMovies(movieId: Int, page: Int)
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
        case .loadMovieDetail(let movieId, _):
            return "/movie/\(movieId)"
        case .loadMovieReview(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .loadSimilarMovies(let movieId, _):
            return "/movie/\(movieId)/similar"
        case .loadImage(let moviePosterUrl):
            return "\(moviePosterUrl)"
        case .genreList:
            return "/genre/movie/list"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        var returnPrm: Parameters = [Constants.APIParameterKey.apiKey: Constants.ProductionServer.apiKey,
                                     Constants.APIParameterKey.language: Constants.ProductionServer.defaultLang,
                                     Constants.APIParameterKey.region: Constants.ProductionServer.defaultRegion]
        switch self {
        case .loadPopularMovies(let page),
                .loadUpcomingMovies(let page),
                .loadNowPlayingMovies(let page),
                .loadMovieReview(_, let page),
                .loadSimilarMovies(_, let page):
            returnPrm[Constants.APIParameterKey.page] = page
        case .loadMovieDetail(let movieId, let appendToResponse):
            returnPrm[Constants.APIParameterKey.movieId] = movieId
            returnPrm[Constants.APIParameterKey.appendToResponse] = appendToResponse
        case .loadImage(moviePosterUrl: _):
            return [:]
        case .genreList:
            break
        }
        
        return returnPrm
    }
    
    private var baseURL: String {
        switch self {
        case .loadImage:
            return Constants.ProductionServer.imageURL
        default:
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
            }
        }
        return urlRequest
    }
    
}
