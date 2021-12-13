//
//  ListViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

class ListViewModel {

    private let restaurantsDataSource: RestaurantsDataSource
    private let notifier: Notifier

    var restaurantsNearby: [Restaurant] = [] {
        didSet {
            restaurantsUpdated?()
        }
    }

    var restaurantsUpdated: (() -> Void)?

    init(restaurantsDataSource: RestaurantsDataSource = RestaurantsNearbyLocationProvider.sharedManager,
         notifier: Notifier = Notifier()) {

        self.restaurantsDataSource = restaurantsDataSource
        self.notifier = notifier

        setupNotifications()
    }

    func loadData(completion: (() -> Void)? = nil) {
        completion?()
    }

    private func setupNotifications() {
        notifier.notify(.resturantsDataSourceDidUpdate) { [weak self] _ in
            if let newRestaurants = self?.restaurantsDataSource.restaurantsNearby {
                self?.restaurantsNearby = newRestaurants
            }
        }
    }
}

