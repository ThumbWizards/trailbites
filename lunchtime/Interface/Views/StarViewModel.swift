//
//  StarViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/13/21.
//

import Foundation

struct StarViewModel {
    let restaurant: Restaurant

    var illuminatedStarCount: Int {
        return restaurant.starCount
    }

    var deluminatedStarCount: Int {
        return 5 - restaurant.starCount
    }
}
