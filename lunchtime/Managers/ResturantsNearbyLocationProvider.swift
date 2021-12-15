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
    case last
}

extension Notification.Name {
    static let resturantsDataSourceDidUpdate = Notification.Name(rawValue: "ResturantsDataSourceDidUpdate")
}

protocol RestaurantsDataSource {
    var restaurantsNearby: [Restaurant] { get }
    var lastSearchedLocation: CLLocationCoordinate2D? { get }
    var hasAny: Bool { get }
    func fetchRestaurants(closestTo: NearbyLocation, searchFilter: String?)
}

class RestaurantsNearbyLocationProvider: RestaurantsDataSource {

    static let sharedManager = RestaurantsNearbyLocationProvider()

    let locationManager: CurrentLocationManagerProtocol
    let restaurantService: RestaurantService
    let notificationProvider: NotificationProvider
    let notifier: Notifier
    let ascendingFilterEnabled: BooleanSetting
    let mainQueue: OperationQueue

    var lastSearchedLocation: CLLocationCoordinate2D?

    var restaurantsNearby: [Restaurant] {
        set {
            self.privateRestaurantsNearby = newValue
        }
        get {
            return privateRestaurantsNearby
        }
    }
    
    private var privateRestaurantsNearby: [Restaurant] = [] {
        didSet {
            notificationProvider.postNotification(name: Notification.Name.resturantsDataSourceDidUpdate.rawValue, object: nil, userInfo: nil)
        }
    }

    var hasAny: Bool {
        return restaurantsNearby.hasElements()
    }

    init(locationManager: CurrentLocationManagerProtocol = CurrentLocationManager(),
         restaurantService: RestaurantService = RestaurantSearch(),
         notificationProvider: NotificationProvider = NotificationCenter.default,
         notifier: Notifier = Notifier(),
         ascendingFilterEnabled: BooleanSetting = Settings.ratingsFilterAscending,
         mainQueue: OperationQueue = OperationQueue.main) {
        self.notifier = notifier
        self.locationManager = locationManager
        self.restaurantService = restaurantService
        self.notificationProvider = notificationProvider
        self.ascendingFilterEnabled = ascendingFilterEnabled
        self.mainQueue = mainQueue

        setupNotifications()
    }

    private func setupNotifications() {
        notifier.notify(.filterUpdated) { [weak self] _ in
            guard let self = self else { return }
            self.privateRestaurantsNearby = self.sortedRestaurants(self.restaurantsNearby)
        }
    }

    func fetchRestaurants(closestTo: NearbyLocation, searchFilter: String? = nil) {
        switch closestTo {
        case .current:
            fetchNearbyRestaurantsAtCurrentLocation()
        case .provided(let alt):
            fetchNearbyRestaurantsAtProvidedLocation(alt)
        case .last:
            if let lastLocation = lastSearchedLocation {
                fetchNearbyRestaurantsAtProvidedLocation(lastLocation, searchFilter: searchFilter)
            }
        }
    }

    private func fetchNearbyRestaurantsAtCurrentLocation() {
        fetchUserCoordinate { [weak self] coordinate in
            guard let self = self else { return }
            guard let userCoordinate = coordinate else {
                return
            }

            self.searchRestaurantsNearby(to: userCoordinate) { [weak self] result in
                self?.lastSearchedLocation = userCoordinate
                self?.mainQueue.addOperation {
                    switch result {
                    case .success(let searchResponse):
                        self?.privateRestaurantsNearby = searchResponse.restaurants
                    case .failure(let error):
                        switch error {
                        case .failedToParse:
                            print("Could not parse json 1")
                        case .unknown(let error):
                            print("error: \(error.localizedDescription))")
                        }
                    }
                }
            }
        }
    }

    private func fetchNearbyRestaurantsAtProvidedLocation(_ location: CLLocationCoordinate2D, searchFilter: String? = nil) {
        searchRestaurantsNearby(to: location, searchFilter: searchFilter) { [weak self] result in
            self?.lastSearchedLocation = location
            self?.mainQueue.addOperation {
                switch result {
                case .success(let searchResponse):
                    self?.privateRestaurantsNearby = self?.sortedRestaurants(searchResponse.restaurants) ?? []
                case .failure(let error):
                    switch error {
                    case .failedToParse:
                        print("Could not parse json 2")
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

    func searchRestaurantsNearby(to coordinate: CLLocationCoordinate2D, searchFilter: String? = nil, completion: @escaping (Result<RestaurantSearchResponse, RestaurantSearchError>) -> Void) {
        let searchParameters = RestaurantSearchParameters(location: coordinate, searchKeyword: searchFilter)
        restaurantService.searchRestaurants(searchParameters: searchParameters, completion: completion)
    }

    private func sortedRestaurants(_ toSort: [Restaurant]) -> [Restaurant] {
        if ascendingFilterEnabled.value == true {
            return toSort.sorted {
                $0.rating ?? 0 < $1.rating ?? 0
            }
        } else {
            return toSort.sorted {
                $0.rating ?? 0 > $1.rating ?? 0
            }
        }
    }
}
