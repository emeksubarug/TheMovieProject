//
//  GenresCollectionViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.06.2022.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genrePoster: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!

}

extension GenresCollectionViewCell {

    func configure(info: GenreInfoModel) {
    self.genreLabel.text = info.name
}
}
