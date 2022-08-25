//
//  ArtistDetailViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 5.08.2022.
//

import UIKit
import TRMosaicLayout

class ArtistDetailViewController: UIViewController,UICollectionViewDelegate {

    @IBOutlet weak var artistDetail: UILabel!
    @IBOutlet weak var artistImageGalleryCollection: UICollectionView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var photoNumber: UILabel!
    @IBOutlet weak var artistMainImage: UIImageView!
    private let viewModel: ArtistDetailViewModel = ArtistDetailViewModel()

    var selectedArtistId: Int?
    private var selectedArtist: Artist?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        let mosaicLayout = TRMosaicLayout()
        self.artistImageGalleryCollection?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        self.viewModel.delegate = self
        self.viewModel.galleryDelegate = self
        if let artistId = self.selectedArtistId {
            self.viewModel.loadImageGallery(artistId: artistId)
            self.viewModel.loadArtistDetail(artistId: artistId)
        }
        artistImageGalleryCollection.delegate = self
        artistImageGalleryCollection.dataSource = self
        
    }
    func configure(selectedArtist: Artist?){
        guard let artist = selectedArtist else {
            return
        }
        self.photoNumber.text = "\(viewModel.numberOfImages()) + Photos "
        self.artistName.text = artist.name
        var urlImage = ""
        do {
            urlImage = try APIRouter.loadImage(moviePosterUrl: "\(artist.profilePath ?? "" )")
                .asURLRequest().url?.absoluteString ?? ""
        } catch {
            debugPrint(error)
        }
        self.artistMainImage.sd_setImage(with: URL(string: urlImage ),
                                     placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func registerNibCell() {
        let  artistCellNib: UINib =  UINib(nibName: "ArtistImageGalleryCell", bundle: nil)
        artistImageGalleryCollection.register(artistCellNib, forCellWithReuseIdentifier: "ArtistImageGalleryCell")
    }
}

extension ArtistDetailViewController: ArtistDetailDelegate {
    func onArtistDetailLoaded(artist: Artist) {
        self.selectedArtist = artist
        configure(selectedArtist: artist)
        artistImageGalleryCollection.reloadData()
    }
}

extension ArtistDetailViewController: UICollectionViewDataSource, TRMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath: IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistImageGalleryCell", for: indexPath)
                as? ArtistImageGalleryCollectionViewCell else {
                    fatalError("cell could not initiated")
                }
        cell.configure(info: viewModel.getInfoImage(for: indexPath))
        return cell
    }
}

extension ArtistDetailViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.artistImageGalleryCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
