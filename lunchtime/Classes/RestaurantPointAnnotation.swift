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
//class RestaurantPointAnnotation: NSObject, MKAnnotation {
//
//    var coordinate: CLLocationCoordinate2D
//    var restaurant: Restaurant
//
//    var title: String? {
//        return restaurant.name
//    }
//
//    init(restaurant: Restaurant) {
//        self.restaurant = restaurant
//        coordinate = CLLocationCoordinate2D(latitude: restaurant.lat, longitude: restaurant.long)
//        super.init()
//    }
//}
