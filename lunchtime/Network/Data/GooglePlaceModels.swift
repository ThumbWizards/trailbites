//
//  Place.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/12/21.
//

import Foundation
import Codextended

struct NearbyResponse: Codable {
    var results: [GooglePlace]

    init(from decoder: Decoder) throws {
        results = try decoder.decode("results")
    }
}

struct GooglePlace: Codable, Restaurant {
    var name: String
    var geometry: GoogleGeometry
    var priceLevel: Int?
    var rating: Double?
    var userRatings: Int?

    var lat: Double {
        return geometry.location.lat
    }

    var long: Double {
        return geometry.location.long
    }

    init(from decoder: Decoder) throws {
        name = try decoder.decode("name")
        geometry = try decoder.decode("geometry")
        priceLevel = try decoder.decodeIfPresent("price_level")
        rating = try decoder.decodeIfPresent("rating")
        userRatings = try decoder.decodeIfPresent("user_ratings_total")
    }
}

struct GoogleGeometry: Codable {
    var location: GoogleLatLong

    init(from decoder: Decoder) throws {
        location = try decoder.decode("location")
    }
}

struct GoogleLatLong: Codable {
    var lat: Double
    var long: Double

    init(from decoder: Decoder) throws {
        lat = try decoder.decode("lat")
        long = try decoder.decode("lng")
    }
}
