//
//  RestaurantViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

class RestuarantViewModel {

    let restaurant: Restaurant

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    var priceText: String {
        var price = ""
        let priceLevel = restaurant.priceLevel ?? 0
        for _ in 0..<priceLevel {
            price += "$"
        }

        if priceLevel == 0 {
            return "N/A • Supporting Text"
        }
        price += " • Supporting Text"
        return price
    }
}
