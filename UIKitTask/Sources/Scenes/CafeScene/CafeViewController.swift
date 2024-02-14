// CafeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран кабинета гостя в приложении, выбор продукта для заказа
final class CafeViewController: UIViewController {
    // MARK: Private Properties

    private enum Constants {
        static let logoImageName = "КофеиновЪ"
        static let guestLabelTitle = "Добро пожаловать,\nГость"
        static let guestViewBackgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 1)
        static let geoViewBackgroundColor = UIColor(red: 235 / 255, green: 246 / 255, blue: 247 / 255, alpha: 1)
        static let geoDescriptionColor = UIColor(red: 156 / 255, green: 161 / 255, blue: 168 / 255, alpha: 1)
        static let pieViewBackgroundColor = UIColor(red: 225 / 255, green: 194 / 255, blue: 160 / 255, alpha: 1)
        static let charLabeltitle = "Г"
        static let geoLabelTitle = "Адреса кофеен"
        static let geoDescriptionTitle = "Разръшите доступъ к геолокацiи для поиска ближайшей кофейни"
        static let geoLocationImageName = "geolocation"
        static let menuImageName = "menu"
        static let pieLabelTitle = "Пти пате аля «РюсЪ»"
        static let pieImageName = "pie"
        static let drinksLabelTitle = "Горячiя напитки"
        static let drinksImageName = "cup"
        static let coffeeLabelTitle = "Кофий"
        static let coffeeImageName = "grains"
    }

    // MARK: - Visual Components

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.logoImageName)
        return imageView
    }()

    private let guestLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .white
        label.text = Constants.guestLabelTitle
        label.numberOfLines = 0
        return label
    }()

    private let guestView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.guestViewBackgroundColor
        view.layer.cornerRadius = 23
        return view
    }()

    private let charLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .white
        label.text = Constants.charLabeltitle
        label.textAlignment = .center
        return label
    }()

    private let menuWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    private let geoView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.geoViewBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()

    private let geoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 12)
        label.textColor = .black
        label.text = Constants.geoLabelTitle
        return label
    }()

    private let geoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdana(withSize: 12)
        label.textColor = Constants.geoDescriptionColor
        label.text = Constants.geoDescriptionTitle
        label.numberOfLines = 0
        return label
    }()

    private let geoLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.geoLocationImageName)
        return imageView
    }()

    private let menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.menuImageName)
        return imageView
    }()

    private let pieView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.pieViewBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()

    private let pieLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.text = Constants.pieLabelTitle
        return label
    }()

    private let pieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.pieImageName)
        return imageView
    }()

    private let drinksView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.pieViewBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()

    private let drinksLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.text = Constants.drinksLabelTitle
        return label
    }()

    private let drinksImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.drinksImageName)
        return imageView
    }()

    private lazy var coffeeView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.pieViewBackgroundColor
        view.layer.cornerRadius = 16
        let gesture = UITapGestureRecognizer(target: self, action: #selector(customViewTapped(_:)))
        view.addGestureRecognizer(gesture)
        return view
    }()

    private let coffeeLabel: UILabel = {
        let label = UILabel()
        label.font = .setVerdanaBold(withSize: 16)
        label.textColor = .black
        label.text = Constants.coffeeLabelTitle
        return label
    }()

    private let coffeeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.coffeeImageName)
        return imageView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        transferToAutorization()
        setupHierarchy()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(guestLabel)
        view.addSubview(guestView)
        view.addSubview(charLabel)
        view.addSubview(menuWhiteView)
        menuWhiteView.addSubview(geoView)
        geoView.addSubview(geoTitleLabel)
        geoView.addSubview(geoDescriptionLabel)
        geoView.addSubview(geoLocationImage)
        menuWhiteView.addSubview(menuImage)
        menuWhiteView.addSubview(pieView)
        pieView.addSubview(pieLabel)
        pieView.addSubview(pieImage)
        menuWhiteView.addSubview(drinksView)
        drinksView.addSubview(drinksLabel)
        drinksView.addSubview(drinksImage)
        menuWhiteView.addSubview(coffeeView)
        coffeeView.addSubview(coffeeLabel)
        coffeeView.addSubview(coffeeImage)
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 120 / 255, green: 84 / 255, blue: 49 / 255, alpha: 1)
        logoImage.frame = .init(x: 100, y: 49, width: 175, height: 76)
        guestLabel.frame = .init(x: 20, y: 147, width: 185, height: 44)
        guestView.frame = .init(x: 311, y: 147, width: 44, height: 44)
        charLabel.frame = .init(x: 311, y: 159, width: 44, height: 19)
        menuWhiteView.frame = .init(x: 0, y: 248, width: 375, height: 564)
        geoView.frame = .init(x: 20, y: 40, width: 335, height: 70)
        geoTitleLabel.frame = .init(x: 15, y: 12, width: 150, height: 15)
        geoDescriptionLabel.frame = .init(x: 15, y: 30, width: 260, height: 30)
        geoLocationImage.frame = .init(x: 289.29, y: 19.92, width: 20.42, height: 29.17)
        menuImage.frame = .init(x: 125, y: 122, width: 125, height: 80)
        pieView.frame = .init(x: 20, y: 216, width: 335, height: 80)
        pieLabel.frame = .init(x: 25, y: 30.5, width: 220, height: 19)
        pieImage.frame = .init(x: 252, y: 5, width: 70, height: 70)
        drinksView.frame = .init(x: 20, y: 316, width: 335, height: 80)
        drinksLabel.frame = .init(x: 25, y: 30, width: 180, height: 19)
        drinksImage.frame = .init(x: 252, y: 20, width: 70, height: 44.66)
        coffeeView.frame = .init(x: 20, y: 416, width: 335, height: 80)
        coffeeLabel.frame = .init(x: 25, y: 30.5, width: 180, height: 19)
        coffeeImage.frame = .init(x: 252, y: 5, width: 70, height: 70)
    }

    private func transferToAutorization() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }

    @objc func customViewTapped(_ gesture: UITapGestureRecognizer) {
        let productOptionsVC = ProductOptionsViewController()
        navigationController?.pushViewController(productOptionsVC, animated: true)
    }
}
