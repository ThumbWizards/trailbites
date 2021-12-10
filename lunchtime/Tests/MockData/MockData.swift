//
//  MockData.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

class MockRestaurants {

    static func restaurantSet() -> [RestaurantDetail] {
        return [
            RestaurantDetail(name: "joe's crab shack"),
            RestaurantDetail(name: "Swiss cheese"),
            RestaurantDetail(name: "Shake Shack")
        ]
    }
}
