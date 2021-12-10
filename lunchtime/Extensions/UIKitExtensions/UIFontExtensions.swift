//
//  UIFontExtensions.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/1/21.
//

import UIKit

extension UIFont.Weight {
    var fontFileSuffix: String? {
        switch self {
            case .heavy:
                return "Heavy"
            case .bold:
                return "Bold"
            case .semibold:
                return "Semibold"
            case .regular:
                return "Regular"
            case .medium:
                return "Medium"
            case .light:
                return "Light"
            case .thin:
                return "Thin"
            case .ultraLight:
                return "Ultralight"
            default:
                return nil
        }
    }
}

public extension UIFont {
    static func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        guard let suffix = weight.fontFileSuffix else {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
        return UIFont(name: "SFProDisplay-\(suffix)", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}

