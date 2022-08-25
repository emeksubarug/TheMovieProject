//
//  RatingUtilities.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.03.2022.
//

import Foundation

class RatingUtilites {
    static func map (minRange: Double, maxRange: Double, minDomain: Double, maxDomain: Double, value: Double) -> Double {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
}
