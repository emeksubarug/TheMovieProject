//
//  ArtistDetailVM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.08.2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos

final class ArtistDetailViewModel {
   weak var galleryDelegate: RequestDelegate?
    var delegate: ArtistDetailDelegate?
    var gallery: [ArtistImage] = []
    private var state: ViewState {
        didSet {
            self.galleryDelegate?.didUpdate(with: state)
        }
    }
    init() {
        self.state = .idle
    }

}
extension ArtistDetailViewModel {
    func loadImageGallery(artistId: Int) {
        APIClient.loadArtistImageGallery(artistId: artistId) { result in
            switch result {
            case .success(let image):
                self.gallery.append(contentsOf: image.profiles!)
                self.state = .success
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        }
    }
    func loadArtistDetail(artistId: Int) {
        APIClient.loadArtistDetail(artistId: artistId, appendToResponse: "credits") { [weak self] result in
            switch result {
            case .success(let artist):
                self?.delegate?.onArtistDetailLoaded(artist: artist)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func numberOfImages() -> Int{
        return gallery.count
    }
    func getImageForIndex(index: Int) -> ArtistImage {
        let realIndex = index % gallery.count
        return gallery[realIndex]
    }
    func getInfoImage(for indexPath: IndexPath) -> String {
        let image = gallery[indexPath.row]
        return image.filePath
    }
}

