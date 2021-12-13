//
//  ResturantsNearbyLocationProvider.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import CoreLocation
import UserNotifications

enum NearbyLocation {
    case current
    case provided(CLLocationCoordinate2D)
}

extension Notification.Name {
    static let resturantsDataSourceDidUpdate = Notification.Name(rawValue: "ResturantsDataSourceDidUpdate")
}

protocol RestaurantsDataSource {
    var restaurantsNearby: [Restaurant] { get }
    var hasAny: Bool { get }
    func fetchRestaurants(closestTo: NearbyLocation)
}

class RestaurantsNearbyLocationProvider: RestaurantsDataSource {

    static let sharedManager = RestaurantsNearbyLocationProvider()

    var restaurantsNearby: [Restaurant] {
        return resturantsNearbyGroup
    }

    let locationManager: CurrentLocationManagerProtocol
    let restaurantService: RestaurantService
    let notificationProvider: NotificationProvider
    let itemLockingQueue = DispatchQueue(label: "itemLockingQueue")
    let mainQueue: OperationQueue

    private var privateResturantsNearbyGroup: [Restaurant] = []
    private var resturantsNearbyGroup: [Restaurant] {
        set {
            itemLockingQueue.sync {
                self.privateResturantsNearbyGroup = newValue
            }
            notificationProvider.post(name: .resturantsDataSourceDidUpdate, object: nil)
        }
        get {
            itemLockingQueue.sync {
                return privateResturantsNearbyGroup
            }
        }
    }

    var hasAny: Bool {
        return restaurantsNearby.hasElements()
    }

    init(locationManager: CurrentLocationManagerProtocol = CurrentLocationManager(),
         restaurantService: RestaurantService = RestaurantSearch(),
         notificationProvider: NotificationProvider = NotificationCenter.default,
         mainQueue: OperationQueue = OperationQueue.main) {
        self.locationManager = locationManager
        self.restaurantService = restaurantService
        self.notificationProvider = notificationProvider
        self.mainQueue = mainQueue
    }

    func fetchRestaurants(closestTo: NearbyLocation) {
        switch closestTo {
        case .current:
            fetchNearbyRestaurantsAtCurrentLocation()
        case .provided(let alt):
            fetchNearbyRestaurantsAtProvidedLocation(alt)
        }
    }

    private func fetchNearbyRestaurantsAtCurrentLocation() {
        fetchUserCoordinate { [weak self] coordinate in
            guard let self = self else { return }
            guard let userCoordinate = coordinate else {
                return
            }

            self.searchRestaurantsNearby(to: userCoordinate) { [weak self] result in
                self?.mainQueue.addOperation {
                    switch result {
                    case .success(let searchResponse):
                        self?.resturantsNearbyGroup = searchResponse.restaurants
                    case .failure(let error):
                        switch error {
                        case .failedToParse:
                            print("Could not parse json")
                        case .unknown(let error):
                            print("error: \(error.localizedDescription))")
                        }
                    }
                }
            }
        }
    }

    private func fetchNearbyRestaurantsAtProvidedLocation(_ location: CLLocationCoordinate2D) {
        searchRestaurantsNearby(to: location) { [weak self] result in
            self?.mainQueue.addOperation {
                switch result {
                case .success(let searchResponse):
                    self?.resturantsNearbyGroup = searchResponse.restaurants
                case .failure(let error):
                    switch error {
                    case .failedToParse:
                        print("Could not parse json")
                    case .unknown(let error):
                        print("error: \(error.localizedDescription))")
                    }
                }
            }
        }
    }

    func fetchUserCoordinate(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        return locationManager.fetchCurrentLocation(completion)
    }

    func searchRestaurantsNearby(to coordinate: CLLocationCoordinate2D, completion: @escaping (Result<RestaurantSearchResponse, RestaurantSearchError>) -> Void) {
        let searchParameters = RestaurantSearchParameters(location: coordinate)
        restaurantService.searchRestaurants(searchParameters: searchParameters, completion: completion)
    }
}
