//
//  Result.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.12.2021.
//

import Foundation

struct Results: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]?

     enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
