//
//  FloatingActionButton.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import UIKit
import MapKit

enum ButtonState {
    case map
    case list
}

class FloatingActionButton: UIButton {

    var buttonState: ButtonState = .map {
        didSet {
            updateButtonState()
        }
    }

    var symbolConfiguration: UIImage.SymbolConfiguration {
        return UIImage.SymbolConfiguration(weight: .bold)
    }

    convenience init(state: ButtonState) {
        self.init(frame: .zero)
        buttonState = state
        updateButtonState()
    }

    private func updateButtonState() {
        switch buttonState {
        case .list:
            configuration?.attributedTitle = "List"
            let listImage = UIImage(systemName: "list.bullet", withConfiguration: symbolConfiguration)?.withTintColor(.white)
            setImage(listImage, for: .normal)
            setNeedsUpdateConfiguration()
        case .map:
            configuration?.attributedTitle = "Map"
            let mapImage = UIImage(systemName: "map", withConfiguration: symbolConfiguration)?.withTintColor(.white)
            setImage(mapImage, for: .normal)
        }
    }
}
