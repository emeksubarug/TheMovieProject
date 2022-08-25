//
//  SeeAllMoviesCollectionViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.02.2022.
//

import UIKit
import Cosmos

class SeeAllMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieGenre: UILabel!

}

extension SeeAllMoviesCollectionViewCell {
    func configure(info: MovieInfoModel) {
    self.movieLabel.text = info.name
    self.ratingView.rating = RatingUtilites.map(minRange: 0, maxRange: 10, minDomain: 0,
                                                maxDomain: 5, value: info.rating ?? 60.0)
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(info.imageURL ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    self.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    }
}
