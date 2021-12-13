//
//  LocationManager.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import CoreLocation

public protocol CurrentLocationManagerProtocol {
    var isCurrentLocationAvailable: Bool { get }
    func fetchCurrentLocation(_ completion: @escaping (CLLocationCoordinate2D?) -> Void)
}

public protocol CLLocationManagerProtocol: AnyObject {
    var delegate: CLLocationManagerDelegate? { get set }
    var distanceFilter: CLLocationDistance { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }

    func requestWhenInUseAuthorization()
    func requestLocation()

    func requestLocationEnabled() -> Bool
    func requestAuthorizationStatus() -> CLAuthorizationStatus
}

extension CLLocationManager: CLLocationManagerProtocol {
    public func requestLocationEnabled() -> Bool { return CLLocationManager.locationServicesEnabled() }
    public func requestAuthorizationStatus() -> CLAuthorizationStatus { return CLLocationManager().authorizationStatus }
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
        return locationManager.requestLocationEnabled()
    }

    var authorizationStatus: CLAuthorizationStatus {
        return locationManager.requestAuthorizationStatus()
    }

    public func fetchCurrentLocation(_ completion: @escaping (CLLocationCoordinate2D?) -> Void) {
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

        // bug
        completion = nil
        print("completion = nil")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
        completion = nil
    }
}
