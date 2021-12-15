//
//  MockData.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
@testable import lunchtime

class MockRestaurants {

    static func restaurantSet() -> [RestaurantDetail] {
        return [
            RestaurantDetail(name: "Joe's Crab Shack", lat: 42.498506, long: -83.557805, priceLevel: 2, rating: 4.1, userRatings: 10001)
        ]
    }

    static var zeroStarRestaurant: RestaurantDetail {
        return RestaurantDetail(name: "Mac n' Cheese Heaven", lat: 42.498506, long: -83.557805, priceLevel: 2, rating: 0, userRatings: 10001)
    }

    static var twoStarRestaurant: RestaurantDetail {
        return RestaurantDetail(name: "Mac n' Cheese Heaven", lat: 42.498506, long: -83.557805, priceLevel: 2, rating: 2.2, userRatings: 10001)
    }

    static var fiveStarRestaurant: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: 2, rating: 5, userRatings: 10001)
    }
}
