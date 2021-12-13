//
//  MapViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import MapKit

class MapViewModel {

    private let locationManager: CurrentLocationManagerProtocol
    private let restaurantsDataSource: RestaurantsDataSource
    private let mainQueue: OperationQueue

    private var currentLocation: CLLocationCoordinate2D? {
        didSet {
            locationUpdated?(currentLocation)
        }
    }

    var restaurantsNearby: [Restaurant] = []
    var locationUpdated: ((CLLocationCoordinate2D?) -> Void)?

    init(locationManager: CurrentLocationManagerProtocol = CurrentLocationManager(),
         restaurantsDataSource: RestaurantsDataSource = RestaurantsNearbyLocationProvider.sharedManager,
         mainQueue: OperationQueue = OperationQueue.main) {
        self.locationManager = locationManager
        self.restaurantsDataSource = restaurantsDataSource
        self.mainQueue = mainQueue

        fetchUserCoordinate { [weak self] coordinate in
            guard let self = self else { return }
            self.currentLocation = coordinate
        }
    }

    private func fetchUserCoordinate(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        return locationManager.fetchCurrentLocation(completion)
    }

    func fetchNearbyRestaurants(at atLocation: CLLocationCoordinate2D? = nil) {
        if let location = atLocation {
            restaurantsDataSource.fetchRestaurants(closestTo: .provided(location))
        } else {
            restaurantsDataSource.fetchRestaurants(closestTo: .current)
        }
    }
}
