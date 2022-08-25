//
//  ContainerViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 7.04.2022.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBAction func exploreCollectionTapped(_ sender: Any) {
        MainFlowController.shared.goToTabbar()
    }
}
