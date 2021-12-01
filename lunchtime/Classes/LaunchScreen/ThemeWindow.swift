//
//  ThemeWindow.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/1/21.
//

import Foundation
import UIKit

public enum UIThemeInterfaceStyle: Int {
    case unspecified
    case light
    case dark
}

extension Notification.Name {
    static let themeInterfaceUpdate = Notification.Name(rawValue: "UIUserThemeInterfaceStyleUpdate")
}

class ThemeWindow: UIWindow {

    let notifier: Notifier
    let uiQueue: OperationQueue
    let themeOverride: IntegerSetting

    init(windowScene: UIWindowScene,
         notifier: Notifier = Notifier(),
         uiQueue: OperationQueue = OperationQueue.main,
         themeOverride: IntegerSetting = Settings.themeOverride) {
        self.notifier = notifier
        self.uiQueue = uiQueue
        self.themeOverride = themeOverride

        super.init(windowScene: windowScene)
        setupNotifications()
        updateStoredTheme()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNotifications() {
        notifier.notify(.themeInterfaceUpdate) { [weak self] notification in
            guard let themeInterfaceValue = notification.userInfo?["value"] as? Int,
                let themeInterface = UIThemeInterfaceStyle(rawValue: themeInterfaceValue) else {
                    self?.updateStoredTheme()
                    return
            }
            self?.themeOverride.value = themeInterfaceValue
            self?.updateTheme(themeOverride: themeInterface)
        }
    }

    func updateStoredTheme() {
        if let storedInterfaceThemeValue = themeOverride.value {
            updateTheme(themeOverride: UIThemeInterfaceStyle(rawValue: storedInterfaceThemeValue))
        }
    }

    func updateTheme(themeOverride: UIThemeInterfaceStyle?) {
        guard let themeOverride = themeOverride,
            let userInterfaceStyle = UIUserInterfaceStyle(rawValue: themeOverride.rawValue) else {
            return
        }
        uiQueue.addOperation { [weak self] in
            self?.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
}
