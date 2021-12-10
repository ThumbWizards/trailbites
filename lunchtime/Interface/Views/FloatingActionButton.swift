//
//  FloatingActionButton.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/10/21.
//

import Foundation
import UIKit

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

    convenience init(state: ButtonState) {
        self.init(type: .custom)
        buttonState = state

        backgroundColor = UIColor.accent
        tintColor = .white
        styleWithRoundedCorners(cornerRadius: 8)
        layer.masksToBounds = true
        updateButtonState()
    }

    private func updateButtonState() {
        switch buttonState {
        case .list:
            setTitle("List", for: .normal)
            let listImage = UIImage(systemName: "list.bullet")?.withTintColor(.white)
            setImage(listImage, for: .normal)
        case .map:
            setTitle("Map", for: .normal)
            let mapImage = UIImage(systemName: "map")?.withTintColor(.white)
            setImage(mapImage, for: .normal)
        }
    }
}
