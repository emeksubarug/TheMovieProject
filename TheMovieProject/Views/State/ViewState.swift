//
//  ViewState.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.04.2022.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
