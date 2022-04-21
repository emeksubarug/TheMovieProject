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
