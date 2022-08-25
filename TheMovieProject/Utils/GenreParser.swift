//
//  GenreParser.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 24.03.2022.
//

import CoreData
import UIKit
import Foundation

class GenreParser {
    var genres: [Int: String] = [:]
    var delegate: GenreDelegate?

     init() {
         TheMovieProject.APIClient.loadGenre() { result in
            switch result {
            case .success(let genre):
                    guard let genreItems = genre.genres else {return}
                    for genre in genreItems {
                        self.genres[genre.id] = genre.name
                    }
            case .failure(let error):
                    print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.genreLoaded()
            }
        }
    }

    func toGenresArray(_ genreIds: [Int]) -> [String] {
        var result: [String] = []
        for id in genreIds {
            if let genre = self.genres[id] {
                result.append(genre)
            }
        }
        return result
    }

    func toString(_ genreIds: [Int]) -> String {
        return toGenresArray(genreIds).joined(separator: " | ")
    }
}
