//
//  LocationManager.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import CoreLocation

protocol CurrentLocationManagerProtocol {
    var isCurrentLocationAvailable: Bool { get }
    func fetchCurrentLocation(_ completion: @escaping (CLLocationCoordinate2D?) -> Void)
}

protocol CLLocationManagerProtocol: AnyObject {
    var delegate: CLLocationManagerDelegate? { get set }
    var distanceFilter: CLLocationDistance { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }

    func requestWhenInUseAuthorization()
    func requestLocation()

    func requestLocationServicesEnabled() -> Bool
    func requestAuthorizationStatus() -> CLAuthorizationStatus
}

extension CLLocationManager: CLLocationManagerProtocol {
    func requestLocationServicesEnabled() -> Bool { return CLLocationManager.locationServicesEnabled() }
    func requestAuthorizationStatus() -> CLAuthorizationStatus { return CLLocationManager().authorizationStatus }
}

class CurrentLocationManager: NSObject, CurrentLocationManagerProtocol {

    private let locationManager: CLLocationManagerProtocol

    init(locationManager: CLLocationManagerProtocol = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.desiredAccuracy = Constants.CurrentLocationManager.desiredAccuracy
        locationManager.distanceFilter = Constants.CurrentLocationManager.distanceFilter
        locationManager.delegate = self
    }

    var completion: ((CLLocationCoordinate2D?) -> Void)?

    var isCurrentLocationAvailable: Bool {
        return allowLocationFetch()
    }

    var locationEnabled: Bool {
        return locationManager.requestLocationServicesEnabled()
    }

    var authorizationStatus: CLAuthorizationStatus {
        return locationManager.requestAuthorizationStatus()
    }

    func fetchCurrentLocation(_ completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        self.completion = completion

        if allowLocationFetch() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        } else {
            completion(nil)
        }
    }

    func allowLocationFetch() -> Bool {
        let locationServicesEnabled = locationEnabled
        let locationAuthorized = authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways || authorizationStatus == .notDetermined
        return locationServicesEnabled && locationAuthorized
    }
}

extension CurrentLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location.coordinate)
        completion = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
        completion = nil
    }
}
