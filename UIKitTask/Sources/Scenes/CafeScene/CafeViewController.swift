// CafeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран кабинета гостя в приложении, выбор продукта для заказа
class CafeViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    // MARK: - IBOutlet

    // MARK: - Visual Components

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "КофеиновЪ")
        return imageView
    }()

    private let guestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-bold", size: 16)
        label.textColor = .white
        label.text = "Добро пожаловать,\nГость"
        label.numberOfLines = 0
        return label
    }()

    private let guestView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 89 / 255, green: 190 / 255, blue: 199 / 255, alpha: 1)
        view.layer.cornerRadius = 23
        return view
    }()

    private let charLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-bold", size: 16)
        label.textColor = .white
        label.text = "Г"
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
        view.backgroundColor = UIColor(red: 235 / 255, green: 246 / 255, blue: 247 / 255, alpha: 1)
        view.layer.cornerRadius = 16
        return view
    }()

    private let geoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-bold", size: 12)
        label.textColor = .black
        label.text = "Адреса кофеен"
        return label
    }()

    private let geoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana", size: 12)
        label.textColor = UIColor(red: 156 / 255, green: 161 / 255, blue: 168 / 255, alpha: 1)
        label.text = "Разръшите доступъ к геолокацiи для поиска ближайшей кофейни"
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 120 / 255, green: 84 / 255, blue: 49 / 255, alpha: 1)
        setupHierarchy()
        setupUI()
    }

    private func setupHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(guestLabel)
        view.addSubview(guestView)
        view.addSubview(charLabel)
        view.addSubview(menuWhiteView)
        menuWhiteView.addSubview(geoView)
        geoView.addSubview(geoTitleLabel)
        geoView.addSubview(geoDescriptionLabel)
//        [
//            logoImage
//        ].forEach { addSubview($0) }
    }

    private func setupUI() {
        logoImage.frame = .init(x: 100, y: 49, width: 175, height: 76)
        guestLabel.frame = .init(x: 20, y: 147, width: 185, height: 44)
        guestView.frame = .init(x: 311, y: 147, width: 44, height: 44)
        charLabel.frame = .init(x: 311, y: 159, width: 44, height: 19)
        menuWhiteView.frame = .init(x: 0, y: 248, width: 375, height: 564)
        geoView.frame = .init(x: 20, y: 40, width: 335, height: 70)
        geoTitleLabel.frame = .init(x: 15, y: 12, width: 150, height: 15)
        geoDescriptionLabel.frame = .init(x: 15, y: 30, width: 260, height: 30)
    }

    // MARK: - Public methods

    // MARK: - IBAction или @objc (not private)

    // MARK: - Private Methods

    // MARK: - IBAction или @objc (private)
}
