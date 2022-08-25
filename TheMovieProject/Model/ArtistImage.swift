//
//  ArtistImage.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.08.2022.
//

import Foundation

struct ArtistGallery: Codable {
    var id: Int
    var profiles: [ArtistImage]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profiles = "profiles"
    }
}

struct ArtistImage: Codable {
    var aspectRatio: Double?
    var height: Int?
    var iso6391: String?
    var filePath: String
    var voteAverage: Double?
    var voteCount: Int?
    var width: Int?

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width = "width"
        case height = "height"
    }
}
