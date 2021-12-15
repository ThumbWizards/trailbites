//
//  RestaurantPointAnnotation.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/13/21.
//

import Foundation
import UIKit
import MapKit

class RestaurantPointAnnotation: MKPointAnnotation {
    var restaurant: Restaurant

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init()
        coordinate = CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.long)
    }
}
