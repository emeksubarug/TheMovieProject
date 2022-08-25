//
//  DiscoverTableTableViewCell.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 10.08.2022.
//

import UIKit


class DiscoverTableViewCell: UITableViewCell {

    var movieBlock: MovieBlockModel?
    @IBOutlet weak var movieCollection: UICollectionView!

    @IBAction func seeAllTapped(_ sender: Any) {
        switch self.movieBlock?.type {
        case .upcoming:
          return  DiscoverFlowController.shared.upcomingSeeAll()
        case .nowPlaying:
          return  DiscoverFlowController.shared.nowPlayingSeeAll()
        case .popular:
          return  DiscoverFlowController.shared.popularSeeAll()
        case .none:
            break
        }
    }
    @IBOutlet weak var collectionType: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        let  discoverCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        movieCollection.register(discoverCellNib, forCellWithReuseIdentifier: "DiscoverCell")
        self.movieCollection.delegate = self
        self.movieCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension DiscoverTableViewCell {
    func configure (movieBlock: MovieBlockModel) {
        self.movieBlock = movieBlock
        self.collectionType.text = movieBlock.type.description
        self.movieCollection.reloadData()
    }
}

extension DiscoverTableViewCell: UICollectionViewDelegate,
                                 UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let id = self.movieBlock?.movies[indexPath.row].id else {
            fatalError("no such item")
        }
        DiscoverFlowController.shared.seeMovieDetail(id: id)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.movieBlock?.movies.count ?? 0
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell",
                                                        for: indexPath) as? DiscoverCollectionViewCell else {
        fatalError("Invalid cell identifier.")
    }
    guard let movie = self.movieBlock?.movies[indexPath.row] else {
        fatalError("no such item")
    }

    cell.configure(info: movie)
    return cell
}
}

