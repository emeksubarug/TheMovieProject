//
//  SeeMoviesViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.02.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos

class SeeMoviesViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate {

    private var isLoadingMore: Bool = false
    private var page: Int = 1
    var type: MovieListType = .nowPlaying
    private let viewModel: SeeMoviesViewModel = SeeMoviesViewModel()
    private let ratingCosmos = CosmosView()
    @IBOutlet weak private var allMoviesCollection: UICollectionView!
    private var category: String {
        return self.type.category
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = type.description
        registerNibCell()
        loadMoviesForCategory()
        page = 1
        allMoviesCollection.dataSource = self
        allMoviesCollection.delegate = self
        self.viewModel.delegate = self
    }

    func registerNibCell() {
        let  moviesAllCellNib: UINib =  UINib(nibName: "MoviesAllCell", bundle: nil)
        allMoviesCollection.register(moviesAllCellNib, forCellWithReuseIdentifier: "SeeAll")
    }

    func loadMoviesForCategory() {
        switch type {
        case .nowPlaying:
            viewModel.loadNowPlayingMovies(page: page)
        case .upcoming:
            viewModel.loadUpcomingMovies(page: page)
        case .popular:
            viewModel.loadPopularMovies(page: page)
        }
    }
    

}

extension SeeMoviesViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch type {
            case .nowPlaying:
                return viewModel.getNumberOfNowPlayingMovies()
            case .upcoming:
                return viewModel.getNumberOfUpcomingMovies()
            case .popular:
                return viewModel.getNumberOfPopularMovies()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath)
                as? SeeAllMoviesCollectionViewCell else {
                    fatalError("cell could not initiated")
                }

            switch type {
            case .nowPlaying:
                cell.configure(info: viewModel.getInfoNowPlayingMovie(for: indexPath))
            case .upcoming:
                cell.configure(info: viewModel.getInfoUpcomingMovie(for: indexPath))
            case .popular:
                cell.configure(info: viewModel.getInfoPopularMovie(for: indexPath))
            }
        let margins = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        cell.frame = cell.frame.inset(by: margins)

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.allMoviesCollection.contentOffset.y >=
            (self.allMoviesCollection.contentSize.height - self.allMoviesCollection.bounds.size.height) {
            if !isLoadingMore {
                isLoadingMore = true
                page += 1
                switch type {
                case .nowPlaying:
                    viewModel.loadNowPlayingMovies(page: page)
                case .upcoming:
                    viewModel.loadUpcomingMovies(page: page)
                case .popular:
                    viewModel.loadPopularMovies(page: page)
                }
                self.allMoviesCollection.reloadData()
                self.isLoadingMore = false
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case MovieListType.upcoming:
            DiscoverFlowController.shared.seeMovieDetail(id: viewModel.getUpcomingMovieForIndex(index: indexPath.row).id!)
        case MovieListType.nowPlaying:
            DiscoverFlowController.shared.seeMovieDetail(id: viewModel.getNowPlayingMovieForIndex(index: indexPath.row).id!)
        case MovieListType.popular:
            DiscoverFlowController.shared.seeMovieDetail(id: viewModel.getPopularMovieForIndex(index: indexPath.row).id!)
        }
    }
}

extension SeeMoviesViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.allMoviesCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
