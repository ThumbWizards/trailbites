//
//  DesignConstants.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import CoreLocation

class DesignConstants { }

class Constants {

    struct Network {
        static let apiKey = "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"
        static let apiBaseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        static let photoBaseURL = "https://maps.googleapis.com/maps/api/place/photo?"
    }

    struct CurrentLocationManager {
        static let desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        static let distanceFilter = 1000.0
        static let defaultLocation = CLLocationCoordinate2D(latitude: 42.498506, longitude: -83.557805)
    }
}
