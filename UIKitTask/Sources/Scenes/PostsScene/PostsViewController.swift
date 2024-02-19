// PostsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран, список постов , сторис, рекомендации
final class PostsViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    // MARK: - Visual Components

    private let appLogoBarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .appLogo
        return imageView
    }()

    private let messagesBarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setImage(.messagesButtonBar, for: .normal)
        return button
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupUI()
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    private func configureNavigationBar() {
        var tabBarItem = UIBarButtonItem(customView: appLogoBarImage)
        navigationItem.leftBarButtonItem = tabBarItem
        tabBarItem = UIBarButtonItem(customView: messagesBarButton)
        navigationItem.rightBarButtonItem = tabBarItem
    }

    private func configureView() {}

    private func setupHierarchy() {}

    private func setupUI() {}

    // MARK: - IBAction или @objc (private)
}
