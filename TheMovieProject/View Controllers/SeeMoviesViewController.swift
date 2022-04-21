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
//    private var delegate: DataSourceDelegate?
    var dataSource: DataSource?
    var type: String = ""

    private let ratingCosmos = CosmosView()

    @IBOutlet weak private var allMoviesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        page = 1
        dataSource?.delegate = self
        allMoviesCollection.dataSource = self
        allMoviesCollection.delegate = self

        self.title = "\(type) Movies"
        if  type == "Most Popular" {
            dataSource?.loadPopularMovies(page: page)
        } else if  type == "Upcoming" {
            dataSource?.loadUpcomingMovies(page: page)
        } else {
            dataSource?.loadNowPlayingMovies(page: page)
        }
    }

    
    func registerNibCell() {
        let  moviesAllCellNib: UINib =  UINib(nibName: "MoviesAllCell", bundle: nil)
        allMoviesCollection.register(moviesAllCellNib, forCellWithReuseIdentifier: "SeeAll")
    }

}

extension SeeMoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "Most Popular"{
            return dataSource?.getNumberOfPopularMovies() ??  0
        } else if type == "Upcoming"{
            return dataSource?.getNumberOfUpcomingMovies() ?? 0
        } else {
            return dataSource?.getNumberOfNowPlayingMovies() ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath)
                as? SeeAllMoviesCollectionViewCell else {
                    fatalError("cell could not initiated")
                }
        var movie: Movie?
        if  type == "Most Popular"{
            movie = dataSource?.getPopularMovieForIndex(index: indexPath.row)
        } else if type == "Upcoming"{
            movie = dataSource?.getUpcomingMovieForIndex(index: indexPath.row)
        } else {
            movie = dataSource?.getNowPlayingMovieForIndex(index: indexPath.row)
        }
        let margins = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        cell.frame = cell.frame.inset(by: margins)
        cell.movieLabel.text = movie?.originalTitle
        var urlImage = ""
        do {
            urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie?.posterPath ?? "")")
                .asURLRequest().url?.absoluteString ?? ""
        } catch {
            debugPrint(error)
        }
        cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                              placeholderImage: UIImage(named: "placeholder.png"))
        cell.ratingView.rating = RatingUtilites.map(minRange: 0, maxRange: 10, minDomain: 0,
                                                    maxDomain: 5, value: movie?.voteAverage ?? 60.0)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.allMoviesCollection.contentOffset.y >=
            (self.allMoviesCollection.contentSize.height - self.allMoviesCollection.bounds.size.height) {
            if !isLoadingMore {
                isLoadingMore = true
                page += 1
                if  type == "Most Popular"{
                    dataSource?.loadPopularMovies(page: page)
                } else if type == "Upcoming"{
                    dataSource?.loadUpcomingMovies(page: page)
                } else {
                    dataSource?.loadNowPlayingMovies(page: page)
                }
                self.allMoviesCollection.reloadData()
                self.isLoadingMore = false
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MovieDetailView", bundle: nil)
        guard let movieDetailsViewController: MovieDetailsViewController =
        storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else {
                    fatalError()
                }
        movieDetailsViewController.selectedMovieId = dataSource?.getPopularMovieForIndex(index: indexPath.row).id
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension SeeMoviesViewController: DataSourceDelegate {
    func mostPopularLoaded() {
        if type == "Most Popular"{
            allMoviesCollection.reloadData()
        }
    }

    func upcomingLoaded() {
        if type == "Upcoming"{
            allMoviesCollection.reloadData()
        }
    }

    func nowPlayingLoaded() {
        if type == "NowPlaying"{
            allMoviesCollection.reloadData()
        }
    }

}
