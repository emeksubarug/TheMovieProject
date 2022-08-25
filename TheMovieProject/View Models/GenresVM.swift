//
//  GenresVM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.06.2022.
//

import Foundation

final class GenresViewModel {

    private let genreParser: GenreParser = GenreParser()
    var genreList: [Genre] = []

    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    init() {
        self.state = .idle
    }
}

extension GenresViewModel {
    var numberOfGenres: Int {
        genreList.count
    }

    func getGenreForIndex(index: Int) -> Genre {
        let realIndex = index % genreList.count
        return genreList[realIndex]
    }

    func getInfoGenre(for indexPath: IndexPath) -> GenreInfoModel {
        let genre = genreList[indexPath.row]
        return GenreInfoModel(name: genre.name, id: genre.id)
    }

    func loadGenre() {
            self.state = .loading
            APIClient.loadGenre() { result in
                switch result {
                case .success(let genre):
                    self.genreList.append(contentsOf: genre.genres!)
                    self.state = .success
                    print("genres---->")
                    print(self.genreList)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .error(error)
                }
            }
    }
}
