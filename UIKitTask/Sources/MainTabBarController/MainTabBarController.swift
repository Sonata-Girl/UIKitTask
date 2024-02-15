// MainTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер, инициализирует запуск стартовых экранов приложения по вкладкам
final class MainTabBarController: UITabBarController {
    // MARK: - Constants

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

        static let appPinkColor = UIColor(red: 225 / 255, green: 24 / 255, blue: 131 / 255, alpha: 1)
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
        tabBar.tintColor = Constants.appPinkColor
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1).cgColor
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
