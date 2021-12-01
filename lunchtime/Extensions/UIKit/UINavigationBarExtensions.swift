//
//  UINavigationBarExtensions.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/1/21.
//

import UIKit

extension UINavigationBar {

    public func defaultStyle() {
        styleNavigationBar(translucent: true)
    }

    @objc public func defaultSolidStyle() {
        styleNavigationBar(translucent: false)
    }

    private func styleNavigationBar(_ barStyle: UIBarStyle = .default,
                                    translucent: Bool = true,
                                    tintColor: UIColor = .toolbarIconFill(),
                                    barTintColor: UIColor = UIColor.toolbarBackground(),
                                    backgroundImage: UIImage? = nil,
                                    shadowImage: UIImage? = nil) {
        self.barStyle = barStyle
        self.isTranslucent = translucent
        self.tintColor = tintColor
        self.barTintColor = barTintColor
        self.titleTextAttributes = [.foregroundColor: UIColor.toolbarTitleText(), .font: UIFont.toolbarTitle()]
        self.setBackgroundImage(backgroundImage, for: .default)
        self.shadowImage = shadowImage
    }

    public func updateNavigationBar(barStyle: UIBarStyle? = nil,
                                    translucent: Bool? = nil,
                                    tintColor: UIColor? = nil) {
        if let barStyle = barStyle {
            self.barStyle = barStyle
        }

        if let translucent = translucent {
            self.isTranslucent = translucent
        }

        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
    }

    public func updateNavigationBarBackgroundImage(_ backgroundImage: UIImage?) {
        self.setBackgroundImage(backgroundImage, for: .default)
    }

    public func showNavigationBarShadow(_ shouldShow: Bool) {
        self.shadowImage = (shouldShow ? nil : UIImage())
    }

    public func styleInvisibleBar(tintColor: UIColor = .toolbarIconFill()) {
        styleNavigationBar(.black,
                           translucent: true,
                           tintColor: tintColor,
                           backgroundImage: UIImage(),
                           shadowImage: UIImage())
    }
}
