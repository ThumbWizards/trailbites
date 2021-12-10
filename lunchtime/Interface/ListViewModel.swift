//
//  ListViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

class ListViewModel {

    var restaurants: [RestaurantDetail] = []

    init() {
        restaurants = MockRestaurants.restaurantSet()
    }

    func loadData(completion: (() -> Void)? = nil) {
        completion?()
    }
}

