//
//  ArtistsCollectionViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.06.2022.
//

import UIKit

class ArtistsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
}

extension ArtistsCollectionViewCell {

    func  configure(info: ArtistInfoModel) {
    self.artistName.text = info.name
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(info.imageURL ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    self.artistImage.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    }
}
