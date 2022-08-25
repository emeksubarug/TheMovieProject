//
//  CarouselItem.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.11.2021.
//
import Foundation
import UIKit

class CarouselItem: UIView {

    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var image: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
}
