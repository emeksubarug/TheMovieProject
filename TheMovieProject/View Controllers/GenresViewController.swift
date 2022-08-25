//
//  GenresViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.06.2022.
//

import UIKit

class GenresViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var genresCollection: UICollectionView!
    private let genreParser: GenreParser = GenreParser()
    private let viewModel: GenresViewModel = GenresViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Genres"
        registerNibCell()
        genresCollection.dataSource = self
        genresCollection.delegate = self
        self.viewModel.delegate = self
        viewModel.loadGenre()
    }

    func registerNibCell() {
        let  artistCellNib: UINib =  UINib(nibName: "GenreCell", bundle: nil)
        genresCollection.register(artistCellNib, forCellWithReuseIdentifier: "GenreCell")
    }
}

extension GenresViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenres
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath)
                as? GenresCollectionViewCell else {
                    fatalError("cell could not initiated")
                }
            cell.configure(info: viewModel.getInfoGenre(for: indexPath))
        return cell
    }
}

extension GenresViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.genresCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
