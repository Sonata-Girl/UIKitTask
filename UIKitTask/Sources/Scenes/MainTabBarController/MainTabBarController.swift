// MainTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер, инициализирует запуск стартовых экранов приложения по вкладкам
final class MainTabBarController: UITabBarController {
<<<<<<<< HEAD:UIKitTask/Sources/Helpers/Scenes/MainTabBarController/MainTabBarController.swift
    // MARK: - Constants
========
    // MARK: Constants
>>>>>>>> bffb9b313505b49632a71c5a7c340cb2fa8e9ecb:UIKitTask/Sources/Scenes/MainTabBarController/MainTabBarController.swift

    enum Constants {
        static let catalogVCTitle = "Каталог"
        static let catalogVCImage = UIImage(named: "catalog")
        static let catalogVCSelectedImage = UIImage(systemName: "catalogRose")

        static let basketVCTitle = "Корзина"
        static let basketVCImage = UIImage(named: "basket")
        static let basketVCSelectedImage = UIImage(named: "basketRose")

        static let profileVCTitle = "Профиль"
        static let profileVCImage = UIImage(named: "profile")
        static let profileVCSelectedImage = UIImage(named: "profileRose")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        setupTabBarViewControllers()
    }

    // MARK: - Private methods

    private func setupTabBarController() {
        view.backgroundColor = .white
        tabBar.tintColor = .appPinkColor()
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = .appTabBarBorderColor()
        tabBar.layer.borderWidth = 1
    }

    private func setupTabBarViewControllers() {
        let catalogVC = UINavigationController(rootViewController: CatalogViewController())
        catalogVC.tabBarItem = UITabBarItem(
            title: Constants.catalogVCTitle,
            image: Constants.catalogVCImage,
            selectedImage: Constants.catalogVCSelectedImage
        )

        let basketVC = UINavigationController(rootViewController: BasketViewController())
        basketVC.tabBarItem = UITabBarItem(
            title: Constants.basketVCTitle,
            image: Constants.basketVCImage,
            selectedImage: Constants.basketVCSelectedImage
        )

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: Constants.profileVCTitle,
            image: Constants.profileVCImage,
            selectedImage: Constants.profileVCSelectedImage
        )

        setViewControllers([catalogVC, basketVC, profileVC], animated: true)
        selectedViewController = catalogVC
    }
}
