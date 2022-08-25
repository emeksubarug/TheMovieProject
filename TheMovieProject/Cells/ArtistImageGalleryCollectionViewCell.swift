//
//  ArtistImageGalleryCollectionViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.08.2022.
//

import UIKit

class ArtistImageGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var artistImage: UIImageView!
}

extension ArtistImageGalleryCollectionViewCell {

    func  configure(info: String) {
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(info)")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    self.artistImage.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    }
}
