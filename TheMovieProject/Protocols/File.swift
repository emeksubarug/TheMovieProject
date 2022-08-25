//
//  File.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.12.2021.
//

import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
