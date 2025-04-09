//
//  SceneDelegate.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 06.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
               let window = UIWindow(windowScene: windowScene)
               
               let initialVC = QuizViewController()
               let navController = UINavigationController(rootViewController: initialVC)
               window.rootViewController = navController
               window.makeKeyAndVisible()
               self.window = window
    }
}
