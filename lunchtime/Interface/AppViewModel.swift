//
//  AppViewModel.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation

enum AppView {
    case map
    case list
}

class AppViewModel {
    var currentView: AppView = .map

    func floatingButtonState() -> ButtonState {
        switch currentView {
        case .map:
            return .list
        case .list:
            return .map
        }
    }
}
