//
//  UserEndpoint.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.12.2021.
//
/*
import Foundation
import Alamofire

enum UserEndpoint: APIConfiguration {
    
    case loadMovies(api_key: String, language: String, page: Int, region: String)
    case loadUpcomingMovies(api_key: String, language: String, page: Int, region: String)
    
    internal var method: HTTPMethod {
           switch self {
           case .loadMovies(_, _, _, _):
               return .get
           case .loadUpcomingMovies(_, _, _, _):
               return .get
           }
       }
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .loadMovies(let api_key, let language, let page, _):
            return "/movie/popular?api_key=\(api_key)&language=\(language)&page=\(page)"
        
        case .loadUpcomingMovies(api_key: let api_key, language: let language, page: let page, region: let region):
            
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        switch self {
        case .loadMovies(api_key: _, language: _, page: _, region: _):
            return nil
        case .loadUpcomingMovies(api_key: _, language: _, page: _, region: _):
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
*/
