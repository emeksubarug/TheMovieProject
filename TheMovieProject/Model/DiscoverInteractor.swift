//
//  DiscoverInteractor.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 15.04.2022.
//

import Foundation
import SDWebImage

class DiscoverInteractor {
    var dataSource = DataSource()

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

    func  configureNowPlayingCell(cell: DiscoverCollectionViewCell, indexPath: IndexPath ) -> DiscoverCollectionViewCell {
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
