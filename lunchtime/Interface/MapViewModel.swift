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
    private let notifier: Notifier

    private var currentLocation: CLLocationCoordinate2D? {
        didSet {
            locationUpdated?(currentLocation)
        }
    }

    var restaurantsNearby: [Restaurant] = [] {
        didSet {
            restaurantsUpdated?()
        }
    }

    var locationUpdated: ((CLLocationCoordinate2D?) -> Void)?
    var restaurantsUpdated: (() -> Void)?

    var annotations: [RestaurantPointAnnotation] {
        return restaurantsNearby.compactMap {
            RestaurantPointAnnotation(restaurant: $0)
        }
    }

    init(locationManager: CurrentLocationManagerProtocol = CurrentLocationManager(),
         restaurantsDataSource: RestaurantsDataSource = RestaurantsNearbyLocationProvider.sharedManager,
         notifier: Notifier = Notifier()) {
        self.locationManager = locationManager
        self.restaurantsDataSource = restaurantsDataSource
        self.notifier = notifier

        setupNotifications()

        fetchUserCoordinate { [weak self] coordinate in
            guard let self = self else { return }
            self.currentLocation = coordinate
        }
    }

    private func setupNotifications() {
        notifier.notify(.resturantsDataSourceDidUpdate) { [weak self] _ in
            if let newRestaurants = self?.restaurantsDataSource.restaurantsNearby {
                self?.restaurantsNearby = newRestaurants
            }
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
