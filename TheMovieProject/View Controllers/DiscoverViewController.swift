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

class DiscoverViewController: UIViewController, UITableViewDelegate {
    var contentOffset: CGFloat = 0


   
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: DiscoverViewModel = DiscoverViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        DiscoverFlowController.shared.rootNV = self.navigationController
        self.navigationItem.title = "Discover Movies"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        registerNibCell()
        self.viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.getMovieBlocks()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        DiscoverFlowController.shared.goToSearchPage()
    }
    
    func registerNibCell() {
        let tableViewCellNib: UINib = UINib(nibName: "DiscoverTableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: "DiscoverTableViewCell")
    }
}
extension DiscoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movieBlock.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell") as?
                DiscoverTableViewCell else {
            fatalError("no cell found")
        }
        cell.configure(movieBlock: self.viewModel.movieBlock[indexPath.row])
        return cell
    }
}

extension DiscoverViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.tableView.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
