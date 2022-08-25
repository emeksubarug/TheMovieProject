//
//  SearchViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 24.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var resultsCollection: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
    }
    private func setUpSearchController() {
        self.navigationItem.titleView = self.searchController.searchBar
    }
}

/*
 extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
*/
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
