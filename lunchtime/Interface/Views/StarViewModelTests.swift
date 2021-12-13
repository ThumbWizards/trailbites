//
//  StarViewModelTests.swift
//  lunchtimeTests
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import XCTest
@testable import lunchtime

class StarViewModelTests: XCTestCase {

    // MARK: - Illuminated Stars

    func testNumberOfIlluminatedStars() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.twoStarRestaurant)
        XCTAssertEqual(viewModel.illuminatedStarCount, 2)
    }

    func testIlluminatedStarsOnZeroStarRestaurant() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.zeroStarRestaurant)
        XCTAssertEqual(viewModel.illuminatedStarCount, 0)
    }

    func testIlluminatedStarsOnFiveStarRestaurant() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.fiveStarRestaurant)
        XCTAssertEqual(viewModel.illuminatedStarCount, 5)
    }


    // MARK: - Deluminated Start

    func testNumberOfDeluminatedStars() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.twoStarRestaurant)
        XCTAssertEqual(viewModel.deluminatedStarCount, 3)
    }

    func testDeluminatedStarsOnZeroStarRestaurant() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.zeroStarRestaurant)
        XCTAssertEqual(viewModel.deluminatedStarCount, 5)
    }

    func testDeluminatedStarsOnFiveStarRestaurant() {
        let viewModel = StarViewModel(restaurant: MockRestaurants.fiveStarRestaurant)
        XCTAssertEqual(viewModel.deluminatedStarCount, 0)
    }
}
