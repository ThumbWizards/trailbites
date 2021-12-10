//
//  SceneDelegate.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/1/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            let window = ThemeWindow(windowScene: windowScene)
            window.rootViewController = AppViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) { }
}

