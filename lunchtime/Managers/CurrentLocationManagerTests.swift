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

}

class MockLocationManagerProtocol: CLLocationManagerProtocol {

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

    init(authorization: CLAuthorizationStatus = .notDetermined,
         locationServicesEnabled: Bool = false) {
        self.authorization = authorization
        self.locationServicesEnabled = locationServicesEnabled
    }
}
