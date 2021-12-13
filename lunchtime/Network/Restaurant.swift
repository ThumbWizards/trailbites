//
//  Restaurant.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

protocol Restaurant {
    var name: String { get }
    var lat: Double { get }
    var long: Double { get }
    var priceLevel: Int? { get }
    var rating: Double? { get }
    var userRatings: Int? { get }
}

struct RestaurantDetail: Restaurant {
    var name: String
    var lat: Double
    var long: Double
    var priceLevel: Int?
    var rating: Double?
    var userRatings: Int?
}
