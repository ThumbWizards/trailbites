//
//  RestaurantViewModelTests.swift
//  lunchtimeTests
//
//  Created by Mark Perkins on 12/14/21.
//

import Foundation
import XCTest
@testable import lunchtime

class RestaurantViewModelTests: XCTestCase {

    func testPriceTextWhenPriceDataMissing() {
        let viewModel = RestuarantViewModel(restaurant: MockRestaurants.missingPrice)
        XCTAssertEqual(viewModel.priceLabelText, "N/A • Open now")
    }

    func testPriceTextWhenPriceAndOpeningHoursMissing() {
        let viewModel = RestuarantViewModel(restaurant: MockRestaurants.missingPriceAndOpeningHours)
        XCTAssertEqual(viewModel.priceLabelText, "N/A • ")
    }

    func testPriceTextWhenExpensiveAndOpen() {
        let viewModel = RestuarantViewModel(restaurant: MockRestaurants.expensiveAndOpen)
        XCTAssertEqual(viewModel.priceLabelText, "$$$$$ • Open now")
    }

    func testPriceTextWhenCheapAndClosed() {
        let viewModel = RestuarantViewModel(restaurant: MockRestaurants.cheapClosed)
        XCTAssertEqual(viewModel.priceLabelText, "$ • Closed")
    }

    func testPriceTextWhenBasicallyFree() {
        let viewModel = RestuarantViewModel(restaurant: MockRestaurants.free)
        XCTAssertEqual(viewModel.priceLabelText, "N/A • ")
    }
}

extension MockRestaurants {
    static var missingPrice: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: nil, isOpenNow: true)
    }

    static var missingPriceAndOpeningHours: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: nil, isOpenNow: nil)
    }

    static var expensiveAndOpen: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: 5, isOpenNow: true)
    }

    static var cheapClosed: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: 1, isOpenNow: false)
    }

    static var free: RestaurantDetail {
        return RestaurantDetail(name: "Five star shack", lat: 42.498506, long: -83.557805, priceLevel: 0)
    }
}
