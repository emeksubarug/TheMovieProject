//
//  UpcomingCollectionViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 23.01.2022.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!

}


extension DiscoverCollectionViewCell {

    func  configure(info: MovieInfoModel) {
    self.movieLabel.text = info.name
    self.movieDuration.text = "Duration"
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(info.imageURL ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    self.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    }
}
