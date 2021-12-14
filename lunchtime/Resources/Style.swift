import CoreGraphics
import Foundation
import UIKit

extension UIFont {
    static func toolbarTitle() -> UIFont {
        return font(size: 16, weight: .medium)
    }

    static func toolbarTitleLarge() -> UIFont {
        return font(size: 24, weight: .medium)
    }
}

extension UIColor {

    static var background: UIColor {
        UIColor(named: "background")!
    }

    static var border: UIColor {
        UIColor(named: "border")!
    }

    static var cardBackground: UIColor {
        UIColor(named: "cardBackground")!
    }

    static var text: UIColor {
        UIColor(named: "text")!
    }

    static var darkText: UIColor {
        return UIColor(named: "darkText")!
    }

    static var button: UIColor {
        return UIColor(named: "button")!
    }

    static var accent: UIColor {
        return UIColor(named: "accent")!
    }

    static var star: UIColor {
        return UIColor(named: "star")!
    }

    static var starAccent: UIColor {
        return UIColor(named: "starAccent")!
    }

    static var lightGray: UIColor {
        return UIColor(named: "lightgray")!
    }
}

extension UIView {

    func styleWithSmallRoundedCorners() {
        layer.cornerRadius = DesignConstants.RoundedView.smallCornerRadius
        layer.masksToBounds = true
    }

    func styleWithRoundedCorners(cornerRadius: CGFloat? = nil) {
        layer.cornerRadius = cornerRadius ?? DesignConstants.RoundedView.cornerRadius
        layer.masksToBounds = true
    }

    func styleAsRoundedCard(backgroundColor: UIColor = UIColor.cardBackground) {
        styleWithRoundedCorners()
        self.backgroundColor = backgroundColor
    }

    func styleWithBottomSmallRoundedCorners() {
        layer.cornerRadius = DesignConstants.RoundedView.smallCornerRadius
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    func styleWithBottomRoundedCorners() {
        layer.cornerRadius = DesignConstants.RoundedView.cornerRadius
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

private extension DesignConstants {
    struct RoundedView {
        static let smallCornerRadius: CGFloat = 2.0
        static let cornerRadius: CGFloat = 8.0
        static let horizontalMargin: CGFloat = 13.0
        static let verticalMargin: CGFloat = 6.0
        static let contentPadding: CGFloat = 16.0
        static let contentSpacing: CGFloat = 8.0
    }
}

extension UIView {
    func withElevation(){
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 7
        layer.shadowColor = UIColor(hex: "33000B26").cgColor
        layer.shadowPath = nil
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
    }
}
