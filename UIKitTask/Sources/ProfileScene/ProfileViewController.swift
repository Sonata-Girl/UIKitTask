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
        static let personDataTitle = "Личные данные"
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
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .cardLogo
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
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


    // MARK: - Public Properties
    // MARK: - Private Properties
    // MARK: - Initializers
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupHierarchy()
        setupLayout()
        configureView()
    }
    // MARK: - Public methods
    // MARK: - IBAction или @objc (not private)
    // MARK: - Private Methods
    // MARK: - IBAction или @objc (private)



}

