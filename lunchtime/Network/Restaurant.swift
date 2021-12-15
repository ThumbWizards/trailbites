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
    var photoReference: String? { get }
    var photoWidth: Int? { get }
    var photoHeight: Int? { get }
    var isOpenNow: Bool? { get }
}

extension Restaurant {
    var starCount: Int {
        guard let rating = rating else {
            return 0
        }
        return Int(floor(rating))
    }

    var asRestaurantDetail: RestaurantDetail {
        return RestaurantDetail(name: name, lat: lat, long: long, priceLevel: priceLevel, rating: rating, userRatings: userRatings)
    }
}

struct RestaurantDetail: Restaurant {
    var name: String
    var lat: Double
    var long: Double
    var priceLevel: Int?
    var rating: Double?
    var userRatings: Int?
    var photoReference: String?
    var photoWidth: Int?
    var photoHeight: Int?
    var isOpenNow: Bool?
}
