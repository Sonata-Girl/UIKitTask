// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Стартовая точка входа в приложение
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }

//        window = UIWindow(windowScene: scene)
//        window?.rootViewController = BillViewController()
//        window?.makeKeyAndVisible()

        let navigationVC = UINavigationController()
        let cafeVC = CafeViewController()

        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationVC
        navigationVC.pushViewController(cafeVC, animated: true)
        window?.makeKeyAndVisible()
    }
}
