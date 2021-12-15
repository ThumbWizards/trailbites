//
//  CLLocationCoordinate2DExtensions.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/15/21.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {}

public func == (_ lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
}
