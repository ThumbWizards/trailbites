import CoreGraphics
import Foundation
import UIKit

public extension UIFont {
    static func toolbarTitle() -> UIFont {
        return font(size: 16, weight: .medium)
    }

    static func toolbarTitleLarge() -> UIFont {
        return font(size: 24, weight: .medium)
    }
}

public extension UIColor {

    var background: UIColor {
        UIColor.purple
    }
    static func button() -> UIColor {
        return UIColor(named: "button")!
    }
    static func toolbarBackground() -> UIColor {
        return UIColor(named: "toolbarBackground")!
    }
    static func toolbarTitleText() -> UIColor {
        return UIColor(named: "toolbarTitleText")!
    }
    static func toolbarIconFill() -> UIColor {
        return UIColor(named: "toolbarIconFill")!
    }
}
