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

struct PlaceholderRestaurant: Restaurant {
    var name: String = ""
    var lat: Double = 0
    var long: Double = 0
    var priceLevel: Int? = 0
    var rating: Double? = 0
    var userRatings: Int? = 0
}
