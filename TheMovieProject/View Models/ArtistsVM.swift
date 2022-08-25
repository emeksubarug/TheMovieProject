//
//  ArtistsVM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.06.2022.
//

import Foundation

final class ArtistsViewModel {
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    var artistList: [Artist] = []

    init() {
        self.state = .idle
    }

}
    extension ArtistsViewModel {
    var numberOfArtists: Int {
        artistList.count
    }

    func getArtistForIndex(index: Int) -> Artist {
        let realIndex = index % artistList.count
        return artistList[realIndex]
    }

    func getInfoArtist(for indexPath: IndexPath) -> ArtistInfoModel {
        let artist = artistList[indexPath.row]
        return ArtistInfoModel(name: artist.name, imageURL: artist.profilePath)
    }

    func loadArtist(page: Int) {
            self.state = .loading
            APIClient.loadArtists(page: page) { result in
                switch result {
                case .success(let movie):
                    self.artistList.append(contentsOf: movie.results!)
                    self.state = .success
                    print(self.artistList)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .error(error)
                }
            }
    }
}
