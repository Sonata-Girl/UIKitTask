// TabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар приложения, разделение на основные экраны
final class TabBarController: UITabBarController {
    // MARK: - Constants

    enum Constants {
        static let postsVCTitle = "Лента"

//        static let postsVCSelectedImage = UIImage(systemName: "catalogRose")

        static let newNotificationsVCTitle = "Уведомления"

//        static let basketVCSelectedImage = UIImage(systemName: "basketRose")

        static let profileVCTitle = "Профиль"

//        static let profileVCSelectedImage = UIImage(systemName: "profileRose")
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
//        tabBar.tintColor = .b
        tabBar.isTranslucent = false
    }

    private func setupTabBarViewControllers() {
        let postsVC = UINavigationController(rootViewController: PostsViewController())
        postsVC.tabBarItem = UITabBarItem(
            title: Constants.postsVCTitle,
            image: .homeTabBar,
            selectedImage: nil
        )

        let newNotificationsVC = UINavigationController(rootViewController: NewNotificationsViewController())
        newNotificationsVC.tabBarItem = UITabBarItem(
            title: Constants.newNotificationsVCTitle,
            image: .newsTabBar,
            selectedImage: nil
        )

        let profileVC = UINavigationController(rootViewController: UIViewController())
        profileVC.tabBarItem = UITabBarItem(
            title: Constants.profileVCTitle,
            image: .profileTabBar,
            selectedImage: nil
        )

        setViewControllers([postsVC, newNotificationsVC, profileVC], animated: true)
        selectedViewController = viewControllers?.first
    }
}
