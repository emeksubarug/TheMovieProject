//
//  Artist.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.06.2022.
//

import Foundation

struct PopularArtists: Codable {
    let page: Int
    let results: [Artist]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct Artist: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String
    let name: String
    let popularity: Double
    let profilePath: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}
