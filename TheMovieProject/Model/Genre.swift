//
//  Genre.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 24.03.2022.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
}

struct GenreResponse: Codable {
    var genres: [Genre]?
}
