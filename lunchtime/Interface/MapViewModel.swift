//
//  MapViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import MapKit

class MapViewModel {

    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

    var currentLocation: CLLocationCoordinate2D? {
        didSet {
            locationUpdated?(currentLocation)
        }
    }

    var locationUpdated: ((CLLocationCoordinate2D?) -> Void)?

    private let locationManager: CurrentLocationManagerProtocol
    private let mainQueue: OperationQueue

    init(locationManager: CurrentLocationManagerProtocol = CurrentLocationManager(),
        mainQueue: OperationQueue = OperationQueue.main) {
        self.locationManager = locationManager
        self.mainQueue = mainQueue

        fetchUserCoordinate { [weak self] coordinate in
            guard let self = self else { return }
            self.currentLocation = coordinate
        }
    }

    func fetchUserCoordinate(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        return locationManager.fetchCurrentLocation(completion)
    }
}
