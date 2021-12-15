//
//  RestaurantSearchParameters.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/12/21.
//

import Foundation
import MapKit

struct RestaurantSearchParameters {
    var location: CLLocationCoordinate2D
    var distanceInMeters: Int = 2500
    var searchKeyword: String? = ""
}
