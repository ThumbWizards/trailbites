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
    var photos: [GooglePhoto]?
    var openingHours: PlaceOpeningHours?

    var lat: Double {
        return geometry.location.lat
    }

    var long: Double {
        return geometry.location.long
    }

    var photoReference: String? {
        return photos?.subscriptSafe(0)?.photoReference
    }

    var photoWidth: Int? {
        return photos?.subscriptSafe(0)?.width
    }

    var photoHeight: Int? {
        return photos?.subscriptSafe(0)?.height
    }

    var isOpenNow: Bool? {
        return openingHours?.openNow ?? nil
    }

    init(from decoder: Decoder) throws {
        name = try decoder.decode("name")
        geometry = try decoder.decode("geometry")
        priceLevel = try decoder.decodeIfPresent("price_level")
        rating = try decoder.decodeIfPresent("rating")
        userRatings = try decoder.decodeIfPresent("user_ratings_total")
        photos = try decoder.decodeIfPresent("photos")
        openingHours = try decoder.decodeIfPresent("opening_hours")
    }
}

struct GoogleGeometry: Codable {
    var location: GoogleLatLong

    init(from decoder: Decoder) throws {
        location = try decoder.decode("location")
    }
}

struct GooglePhoto: Codable {
    var photoReference: String
    var height: Int
    var width: Int

    init(from decoder: Decoder) throws {
        photoReference = try decoder.decode("photo_reference")
        height = try decoder.decode("height")
        width = try decoder.decode("width")
    }
}

struct PlaceOpeningHours: Codable {
    var openNow: Bool?

    init(from decoder: Decoder) throws {
        openNow = try decoder.decodeIfPresent("open_now")
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
