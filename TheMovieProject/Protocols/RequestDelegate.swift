//
//  RequestDelegate.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.04.2022.
//

import Foundation


protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
