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

    private var priceText: String {
        var price = ""
        let priceLevel = restaurant.priceLevel ?? 0
        for _ in 0..<priceLevel {
            price += "$"
        }

        if priceLevel == 0 {
            return "N/A • "
        }
        price += " • "
        return price
    }

    private var hoursText: String {
        guard let openNow = restaurant.isOpenNow else {
            return ""
        }
        return openNow ? "Open now" : "Closed"
    }

    var priceLabelText: String {
        return priceText + hoursText
    }
}
