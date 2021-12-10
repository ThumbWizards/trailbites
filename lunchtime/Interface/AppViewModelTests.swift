//
//  AppViewModelTests.swift
//  lunchtimeTests
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import XCTest
@testable import lunchtime

class AppViewModelTests: XCTestCase {
    func testButtonStateIsListWhenViewisMap() {
        let viewModel = AppViewModel()
        viewModel.currentView = .map
        XCTAssertEqual(viewModel.floatingButtonState(), .list)
    }

    func testButtonStateIsMapWhenViewisList() {
        let viewModel = AppViewModel()
        viewModel.currentView = .list
        XCTAssertEqual(viewModel.floatingButtonState(), .map)
    }
}
