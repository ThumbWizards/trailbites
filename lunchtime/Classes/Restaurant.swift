//
//  Restaurant.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation

protocol Restaurant {
    var name: String { get }
}

struct RestaurantDetail: Restaurant {
    var name: String = ""
}
