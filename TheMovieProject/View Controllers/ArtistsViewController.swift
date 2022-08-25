//
//  ArtistsViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 25.05.2022.
//

import UIKit

class ArtistsViewController: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var artistsCollection: UICollectionView!
    private let viewModel: ArtistsViewModel = ArtistsViewModel()
    private var page: Int = 1
    private var isLoadingMore: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Artists"
        self.navigationItem.hidesBackButton = true
        registerNibCell()
        page = 1
        artistsCollection.dataSource = self
        artistsCollection.delegate = self
        self.viewModel.delegate = self
        viewModel.loadArtist(page: page)
       definesPresentationContext = true

}

    func registerNibCell() {
        let  artistCellNib: UINib =  UINib(nibName: "ArtistCell", bundle: nil)
        artistsCollection.register(artistCellNib, forCellWithReuseIdentifier: "ArtistCell")
    }
}

extension ArtistsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "ArtistDetail", bundle: nil)
       guard let artistDetailViewController: ArtistDetailViewController =
        storyboard?.instantiateViewController(withIdentifier: "ArtistDetailViewController")
                as? ArtistDetailViewController else {
                    fatalError("storyboard could not be initiated")
                }
        navigationController?.pushViewController(artistDetailViewController, animated: true)
        artistDetailViewController.selectedArtistId = viewModel.getArtistForIndex(index: indexPath.row).id
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfArtists
    }

func collectionView(_ collectionView: UICollectionView,
                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath)
                as? ArtistsCollectionViewCell else {
                    fatalError("cell could not initiated")
                }
            cell.configure(info: viewModel.getInfoArtist(for: indexPath))
        return cell

        }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.artistsCollection.contentOffset.y >=
            (self.artistsCollection.contentSize.height - self.artistsCollection.bounds.size.height) {
            if !isLoadingMore {
                isLoadingMore = true
                page += 1
                viewModel.loadArtist(page: page)
                self.artistsCollection.reloadData()
                self.isLoadingMore = false
            }
        }
    }
}

extension ArtistsViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.artistsCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
