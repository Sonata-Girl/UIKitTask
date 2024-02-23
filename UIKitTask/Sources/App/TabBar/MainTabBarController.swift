// MainTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таббар приложения, разделение на основные экраны
final class MainTabBarController: UITabBarController {
    // MARK: Constants

    enum Constants {
        static let postsVCTitle = "Лента"
        static let newNotificationsVCTitle = "Уведомления"
        static let profileVCTitle = "Профиль"
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        setupTabBarViewControllers()
    }

    // MARK: Private methods

    private func setupTabBarController() {
        view.backgroundColor = .white
        tabBar.isTranslucent = false
    }

    private func setupTabBarViewControllers() {
        let postsViewController = UINavigationController(rootViewController: PostsViewController())
        postsViewController.tabBarItem = UITabBarItem(
            title: Constants.postsVCTitle,
            image: .homeTabBar,
            selectedImage: nil
        )

        let newNotificationsViewController =
            UINavigationController(rootViewController: NewNotificationsViewController())
        newNotificationsViewController.tabBarItem = UITabBarItem(
            title: Constants.newNotificationsVCTitle,
            image: .newsTabBar,
            selectedImage: nil
        )

        let profileViewController = UINavigationController(rootViewController: UIViewController())
        profileViewController.tabBarItem = UITabBarItem(
            title: Constants.profileVCTitle,
            image: .profileTabBar,
            selectedImage: nil
        )

        setViewControllers([postsViewController, newNotificationsViewController, profileViewController], animated: true)
        selectedViewController = viewControllers?.first
    }
}
