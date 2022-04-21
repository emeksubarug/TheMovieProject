//
//  MovieDetailsViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 9.03.2022.
//
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos
class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    var selectedMovieId: Int?

    private var selectedMovie: Movie?
    private var genreParser: GenreParser? = GenreParser()
    private var dataSource: MovieDetailDataSource = MovieDetailDataSource()

    override func viewWillAppear(_ animated: Bool) {
        self.genreParser?.delegate = self
        self.dataSource.delegate = self
        if let movieId = self.selectedMovieId {
            self.dataSource.loadMovieDetail(movieId: movieId)
        }
    }

    private func configure() {
        guard let movie = selectedMovie else { return }
        self.movieTitle.text = movie.originalTitle
        self.releaseDate.text = movie.releaseDate
        if let language = LanguageType(rawValue: movie.originalLanguage ?? "en") {
            self.movieLanguage.text = "Language: \(language.language)"
        }
        self.movieDescription.text = movie.overview
        var urlImage = ""
        do {
            urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie.posterPath ?? "" )")
                .asURLRequest().url?.absoluteString ?? ""
        } catch {
            debugPrint(error)
        }
        self.moviePoster.sd_setImage(with: URL(string: urlImage ),
                                     placeholderImage: UIImage(named: "placeholder.png"))
        self.thumbnail.sd_setImage(with: URL(string: urlImage),
                                   placeholderImage: UIImage(named: "placeholder.png"))
        self.ratingView.rating = RatingUtilites.map(minRange: 0, maxRange: 10,
                                                    minDomain: 0, maxDomain: 5, value: movie.voteAverage ?? 0.0)
        self.ratingNumber.text = "\(RatingUtilites.map(minRange: 0, maxRange: 10, minDomain: 0, maxDomain: 5, value: movie.voteAverage ?? 0.0)) / 10"
    }
}

extension MovieDetailsViewController: GenreDelegate {
    func genreLoaded() {
        if let genreArray = selectedMovie?.genreIds {
            self.movieGenre.text = genreParser?.toString(genreArray)
        }
    }
}

extension MovieDetailsViewController: MovieDetailDataSourceDelegate {
    func onMovieDetailLoaded(movie: Movie) {
        self.selectedMovie = movie
        self.configure()
    }
}
