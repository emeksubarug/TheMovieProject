//
//  DiscoverViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class DiscoverViewController: UIViewController, UICollectionViewDelegate {
    var contentOffset: CGFloat = 0
    var dataSource = DataSource()

    @IBAction func upcomingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "Upcoming"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func mostPopularTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "Most Popular"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func nowPlayingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "NowPlaying"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBOutlet weak var nowPlayingMoviesCollection: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollection: UICollectionView!
    @IBOutlet weak var popularMoviesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        dataSource.delegate = self
        dataSource.loadPopularMovies(page: 1)
        dataSource.loadUpcomingMovies(page: 1)
        dataSource.loadNowPlayingMovies(page: 1)
        self.title = "Discover Movies"
    }

    func registerNibCell() {
        let  discoverCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        upcomingMoviesCollection.register(discoverCellNib, forCellWithReuseIdentifier: "DiscoverCell")
        let  nowPlayingCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        nowPlayingMoviesCollection.register(nowPlayingCellNib, forCellWithReuseIdentifier: "DiscoverCell")
        let  popularMoviesCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        popularMoviesCollection.register(popularMoviesCellNib, forCellWithReuseIdentifier: "DiscoverCell")
    }

    func  configurePopularCell(cell: DiscoverCollectionViewCell, indexPath: IndexPath ) -> DiscoverCollectionViewCell {
    let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
    cell.movieLabel.text = movie.originalTitle
    cell.movieDuration.text = "Duration"
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie.posterPath ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    return cell
}

    func  configureNowPlayingCell(cell: DiscoverCollectionViewCell,
                                  indexPath: IndexPath ) -> DiscoverCollectionViewCell {
    let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
    cell.movieLabel.text = movie.originalTitle
    cell.movieDuration.text = "Duration"
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie.posterPath ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    return cell
}

    func configureUpcomingCell(cell: DiscoverCollectionViewCell, indexPath: IndexPath ) -> DiscoverCollectionViewCell {
    let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
    cell.movieLabel.text = movie.originalTitle
    cell.movieDuration.text = "Duration"
    var urlImage = ""
    do {
        urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie.posterPath ?? "")")
            .asURLRequest().url?.absoluteString ?? ""
    } catch { fatalError("image cannot be cathced")}
    cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    return cell
}
}

extension DiscoverViewController: DataSourceDelegate {
    func nowPlayingLoaded() {
        nowPlayingMoviesCollection.reloadData()
    }
    func upcomingLoaded() {
        upcomingMoviesCollection.reloadData()
    }
    func mostPopularLoaded() {
        popularMoviesCollection.reloadData()
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MovieDetailView", bundle: nil)
       guard let movieDetailsViewController: MovieDetailsViewController =
        storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else {
                    fatalError("storyboard could not be initiated")
                }
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
        if collectionView == nowPlayingMoviesCollection {
            movieDetailsViewController.selectedMovieId = dataSource.getNowPlayingMovieForIndex(index: indexPath.row).id

        } else if collectionView == popularMoviesCollection {
            movieDetailsViewController.selectedMovieId = dataSource.getPopularMovieForIndex(index: indexPath.row).id

        } else {
            movieDetailsViewController.selectedMovieId = dataSource.getUpcomingMovieForIndex(index: indexPath.row).id
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularMoviesCollection {
            return dataSource.getNumberOfPopularMovies()
        } else if collectionView == self.upcomingMoviesCollection {
            return dataSource.getNumberOfUpcomingMovies() } else { return dataSource.getNumberOfNowPlayingMovies() }
    }

    // TODO: to shorten the function, separate into 3 by movies collection type

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell",
                                                            for: indexPath) as? DiscoverCollectionViewCell else {
            fatalError("Invalid cell identifier.")
        }

        if collectionView == self.popularMoviesCollection {
            return configurePopularCell(cell: cell, indexPath: indexPath)
        } else if collectionView == self.upcomingMoviesCollection {
            return configureUpcomingCell(cell: cell, indexPath: indexPath)
        } else {
            return configureNowPlayingCell(cell: cell, indexPath: indexPath)
        }
    }
}
