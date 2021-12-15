//
//  CurrentLocationManagerTests.swift
//  lunchtimeTests
//
//  Created by Mark Perkins on 12/14/21.
//

import Foundation
import XCTest
@testable import lunchtime
import CoreLocation

class CurrentLocationManagerTests: XCTestCase {

    func testAllowedLocationFetchingWhenAuthorizedAndServicesOn() {
        let mockLocationManager = MockLocationManagerProtocol(authorization: .authorizedAlways, locationServicesEnabled: true)
        let manager = CurrentLocationManager(locationManager: mockLocationManager)
        XCTAssertEqual(manager.allowLocationFetch(), true)
    }

    func testRestrictLocationFetchingWhenNotAuthorized() {
        let mockLocationManager = MockLocationManagerProtocol(authorization: .restricted, locationServicesEnabled: true)
        let manager = CurrentLocationManager(locationManager: mockLocationManager)
        XCTAssertEqual(manager.allowLocationFetch(), false)
    }

    func testRestrictLocationFetchingWhenServicesDisabled() {
        let mockLocationManager = MockLocationManagerProtocol(authorization: .authorizedWhenInUse, locationServicesEnabled: false)
        let manager = CurrentLocationManager(locationManager: mockLocationManager)
        XCTAssertEqual(manager.allowLocationFetch(), false)
    }

    func testRestrictLocationFetchingWhenNotAuthorizedAndServicesDisabled() {
        let mockLocationManager = MockLocationManagerProtocol(authorization: .denied, locationServicesEnabled: false)
        let manager = CurrentLocationManager(locationManager: mockLocationManager)
        XCTAssertEqual(manager.allowLocationFetch(), false)
    }

    func testLocationNilWhenLocationRestricted() {
        let disabledMockManager = MockLocationManagerProtocol(authorization: .denied, locationServicesEnabled: false)
        let manager = CurrentLocationManager(locationManager: disabledMockManager)
        var result: CLLocationCoordinate2D?
        manager.fetchCurrentLocation { coordinate in
            result = coordinate
        }
        XCTAssertNil(result)
    }

    func testLocationExistsWhenLocationEnabled() {
        let enabledMockManager = MockLocationManagerProtocol(mockLocation: CLLocation(), authorization: .authorizedWhenInUse, locationServicesEnabled: true)
        let manager = CurrentLocationManager(locationManager: enabledMockManager)
        let location = CLLocation(latitude: 1.0, longitude: 2.0)

        var result: CLLocationCoordinate2D?
        manager.fetchCurrentLocation { coordinate in
            result = coordinate
        }
        manager.locationManager(CLLocationManager(), didUpdateLocations: [location])
        XCTAssertEqual(result, location.coordinate)
    }
}

class MockLocationManagerProtocol: CLLocationManagerProtocol {

    let mockLocation: CLLocation?
    let authorization: CLAuthorizationStatus
    let locationServicesEnabled: Bool

    var didCallRequestAuthorizationStatus = false
    var didCallRequestLocationServicesEnabled = false
    var didCallRequestLocation = false
    var didCallRequestWhenInUse = false

    var delegate: CLLocationManagerDelegate? = nil
    var distanceFilter: CLLocationDistance = 1000
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyNearestTenMeters

    func requestWhenInUseAuthorization() {
        didCallRequestWhenInUse = true
    }

    func requestLocation() {
        didCallRequestLocation = true
    }

    func requestLocationServicesEnabled() -> Bool {
        didCallRequestLocationServicesEnabled = true
        return locationServicesEnabled
    }

    func requestAuthorizationStatus() -> CLAuthorizationStatus {
        didCallRequestAuthorizationStatus = true
        return authorization
    }

    init(mockLocation: CLLocation = CLLocation(),
         authorization: CLAuthorizationStatus = .notDetermined,
         locationServicesEnabled: Bool = false) {
        self.mockLocation = mockLocation
        self.authorization = authorization
        self.locationServicesEnabled = locationServicesEnabled
    }
}
