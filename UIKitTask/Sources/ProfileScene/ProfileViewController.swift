// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран личного кабинета, профиля
final class ProfileViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: Constants

    private enum Constants {
        static let screenTitle = "Профиль"
        static let userCardNumber = "1000 0001 0102"
        static let discountPercentTitle = "15%"
        static let personalDataTitle = "Личные данные"
        static let myDataTitle = "Мои данные"
        static let toTakeFriendTitle = "Приведи друга"
        static let feedBackTitle = "Обратная связь"

//        static let cardLogo: UIImage = .cardLogo
//        static let qrLogo: UIImage = .qrIcon
//        static let myDataIcon: UIImage = .myDataIcon
//        static let takeFriendIcon: UIImage = .takeFriendIcon
//        static let feedBackIcon: UIImage = .feedBackIcon

        static let infoLogo = UIImage(systemName: "info.circle.fill")
    }

    // MARK: - Visual Components

    private let profileScreenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
         label.textAlignment = .center
        return label
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        view.layer.shadowColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 0.25)
        view.layer.shadowOffset = .init(width: 0, height: -4)
        return view
    }()

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .cardLogo
        return imageView
    }()

    private let qrImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .qrIcon
        imageView.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 0.1)
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.infoLogo
        imageView.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 0.1)
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let myDataTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.personalDataTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let myDataSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .myDataIcon
        return imageView
    }()

    private let myDataSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.myDataTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let myDataDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }()

    private let takeFriendSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .takeFriendIcon
        return imageView
    }()

    private let takeFriendSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.toTakeFriendTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let takeFriendDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }()

    private let feedBackSectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .feedBackIcon
        return imageView
    }()

    private let feedBackSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.feedBackTitle
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .label
        return label
    }()

    private let feedBackDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        tabBarItem.badgeColor = .black
        tabBarItem.title = "Hello"
        self.tabBarItem = tabBarItem
//        configureNavigationBar()
//        setupHierarchy()
//        setupLayout()
//        configureView()
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    // MARK: - IBAction или @objc (private)
}
